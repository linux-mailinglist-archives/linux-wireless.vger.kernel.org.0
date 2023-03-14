Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0816B9196
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCNL0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCNL0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 07:26:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A2685377
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XUMBdeYi2MpQFVAgjpKFXuZzBab5X0dzIQIPvL0Kbbg=;
        t=1678793207; x=1680002807; b=lhv5JPqbqhlmd5RLPN570fS8Fsvyby0Ly/+fC33a2bvtPjQ
        kzKwu9VTii4cOeRNU7cHvCWZAXDnh9mortjIHah3GBEUevoX/rkx9u2BfeeFguh9b/Z1tsB+Cz6HW
        UzFVb968e98VKModr6Kq+tdPKIaQB9seV+l6J+V3I3nfveBq3FHc5zyK8k0zCdVb3afhecbjK5AyF
        o1CKV2fiKfOCo4K8q0Bhh2rOMbApNgmcL/+/rj3+QHimmFq9P3LsJM3lJYENKzEwNW3Mcu8jFKvHS
        hefYH143FKntORkucaNkG9HrSv0/c1ZcJPPL7IaU7Mea/zrA0KDspCzz3XiYmniA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pc2nY-0038e8-1G;
        Tue, 14 Mar 2023 12:26:32 +0100
Message-ID: <5674c40151267fea1333f0eda1701b141bbaa170.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: mvm: fix double list_add at
 iwl_mvm_mac_wake_tx_queue (roaming)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Cc:     Petr Stourac <pstourac@redhat.com>
Date:   Tue, 14 Mar 2023 12:26:31 +0100
In-Reply-To: <20230314103840.30771-1-jtornosm@redhat.com>
References: <20230314103840.30771-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Issues like this, in scenarios with continuous roaming, have been reporte=
d:

Can you say where? Any public reports?

> This can be reproduced with a single script from the station:
>     while true; do
>         wpa_cli -i wlp3s0 roam 34:13:E8:B1:DB:9A
>         sleep 2
>         wpa_cli -i wlp3s0 roam 34:13:E8:3C:FB:DB
>         sleep 2
>     done
> And flooding with tx traffic.

Oh, nice to have a reproducer.


Funny thing is, I was _just_ looking at this exact bug, because we were
discussing all this concurrency over in

https://lore.kernel.org/r/20230313201542.72325-1-alexander@wetzel-home.de

> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -787,11 +787,18 @@ static void iwl_mvm_mac_wake_tx_queue(struct ieee80=
211_hw *hw,
>  		return;
>  	}
> =20
> +	spin_lock_bh(&mvmtxq->list_lock);
> +
>  	/* The list is being deleted only after the queue is fully allocated. *=
/
> -	if (!list_empty(&mvmtxq->list))
> +	if (!list_empty(&mvmtxq->list)) {
> +		spin_unlock_bh(&mvmtxq->list_lock);
>  		return;
> +	}
> =20
>  	list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
> +
> +	spin_unlock_bh(&mvmtxq->list_lock);


While this might fix the issue as far as you could observe, that is
clearly not sufficient, since you don't protect the list on the other
side, where the items are removed from it again.

Below are the two patches that I've come up with so far, if anyone wants
to try them. Please ignore all the extra metadata, I exported this
directly from our internal code base.

johannes


From 191299b19eeb95a92a78152c1b15bec3d77b7a5b Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Mon, 13 Mar 2023 22:23:19 +0100
Subject: [PATCH 1/2] [BUGFIX] wifi: iwlwifi: mvm: fix mvmtxq->stopped handl=
ing

This could race if the queue is redirected while full, then
the flushing internally would start it while it's not yet
usable again. Fix it by using two state bits instead of just
one.

type=3Dbugfix
ticket=3Dnone
fixes=3DI37dfb07e617ba0ba6fad55eaf7bd7b28bd24b82e

Change-Id: I68fc8d1a16a7c6927ac92fe855ada741acb9fe14
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac80211.c
index b068639f516b..cc51469cccdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -961,7 +961,10 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, st=
ruct ieee80211_txq *txq)
=20
 	rcu_read_lock();
 	do {
-		while (likely(!mvmtxq->stopped &&
+		while (likely(!test_bit(IWL_MVM_TXQ_STATE_STOP_FULL,
+					&mvmtxq->state) &&
+			      !test_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT,
+					&mvmtxq->state) &&
 			      !test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))) {
 			skb =3D ieee80211_tx_dequeue(hw, txq);
=20
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/mvm.h
index f598f0c7d145..8040ad4c13b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -789,7 +789,9 @@ struct iwl_mvm_txq {
 	struct list_head list;
 	u16 txq_id;
 	atomic_t tx_request;
-	bool stopped;
+#define IWL_MVM_TXQ_STATE_STOP_FULL	0
+#define IWL_MVM_TXQ_STATE_STOP_REDIRECT	1
+	unsigned long state;
 };
=20
 static inline struct iwl_mvm_txq *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/ops.c
index f4df101fac58..1a925ea9f822 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2000,7 +2000,10 @@ static void iwl_mvm_queue_state_change(struct iwl_op=
_mode *op_mode,
=20
 		txq =3D sta->txq[tid];
 		mvmtxq =3D iwl_mvm_txq_from_mac80211(txq);
-		mvmtxq->stopped =3D !start;
+		if (start)
+			clear_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
+		else
+			set_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
=20
 		if (start && mvmsta->sta_state !=3D IEEE80211_STA_NOTEXIST) {
 			local_bh_disable();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/sta.c
index e8f38db02dc2..5b39da622f37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -730,7 +730,7 @@ static int iwl_mvm_redirect_queue(struct iwl_mvm *mvm, =
int queue, int tid,
 			    queue, iwl_mvm_ac_to_tx_fifo[ac]);
=20
 	/* Stop the queue and wait for it to empty */
-	txq->stopped =3D true;
+	set_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT, &txq->state);
=20
 	ret =3D iwl_trans_wait_tx_queues_empty(mvm->trans, BIT(queue));
 	if (ret) {
@@ -773,7 +773,7 @@ static int iwl_mvm_redirect_queue(struct iwl_mvm *mvm, =
int queue, int tid,
=20
 out:
 	/* Continue using the queue */
-	txq->stopped =3D false;
+	clear_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT, &txq->state);
=20
 	return ret;
 }
--=20
2.39.2


From 7001088d33bf1ad9c9c5f24a59502b2a0e89a25b Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Mon, 13 Mar 2023 22:53:19 +0100
Subject: [PATCH 2/2] [BUGFIX] wifi: iwlwifi: mvm: protect TXQ list
 manipulation

Some recent upstream debugging uncovered the fact that in
iwlwifi, the TXQ list manipulation is racy.

Introduce a new state bit for when the TXQ is completely
ready and can be used without locking, and if that's not
set yet acquire the lock to check everything correctly.

type=3Dbugfix
ticket=3Dnone
fixes=3DI37dfb07e617ba0ba6fad55eaf7bd7b28bd24b82e

Change-Id: Ife6276980e699d6d8dc0307bfd3a87b36c3e02d0
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 41 +++++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 25 +++++++++--
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac80211.c
index cc51469cccdd..fb3c22fb1ae4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -989,42 +989,21 @@ void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *h=
w,
 	struct iwl_mvm *mvm =3D IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_txq *mvmtxq =3D iwl_mvm_txq_from_mac80211(txq);
=20
-	/*
-	 * Please note that racing is handled very carefully here:
-	 * mvmtxq->txq_id is updated during allocation, and mvmtxq->list is
-	 * deleted afterwards.
-	 * This means that if:
-	 * mvmtxq->txq_id !=3D INVALID_QUEUE && list_empty(&mvmtxq->list):
-	 *	queue is allocated and we can TX.
-	 * mvmtxq->txq_id !=3D INVALID_QUEUE && !list_empty(&mvmtxq->list):
-	 *	a race, should defer the frame.
-	 * mvmtxq->txq_id =3D=3D INVALID_QUEUE && list_empty(&mvmtxq->list):
-	 *	need to allocate the queue and defer the frame.
-	 * mvmtxq->txq_id =3D=3D INVALID_QUEUE && !list_empty(&mvmtxq->list):
-	 *	queue is already scheduled for allocation, no need to allocate,
-	 *	should defer the frame.
-	 */
-
-	/* If the queue is allocated TX and return. */
-	if (!txq->sta || mvmtxq->txq_id !=3D IWL_MVM_INVALID_QUEUE) {
-		/*
-		 * Check that list is empty to avoid a race where txq_id is
-		 * already updated, but the queue allocation work wasn't
-		 * finished
-		 */
-		if (unlikely(txq->sta && !list_empty(&mvmtxq->list)))
-			return;
-
+	if (likely(test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) ||
+	    !txq->sta) {
 		iwl_mvm_mac_itxq_xmit(hw, txq);
 		return;
 	}
=20
+	spin_lock_bh(&mvm->add_stream_lock);
 	/* The list is being deleted only after the queue is fully allocated. */
-	if (!list_empty(&mvmtxq->list))
-		return;
-
-	list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
-	schedule_work(&mvm->add_stream_wk);
+	if (list_empty(&mvmtxq->list) &&
+	    /* recheck under lock */
+	    !test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) {
+		list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
+		schedule_work(&mvm->add_stream_wk);
+	}
+	spin_unlock_bh(&mvm->add_stream_lock);
 }
=20
 #define CHECK_BA_TRIGGER(_mvm, _trig, _tid_bm, _tid, _fmt...)		\
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/mvm.h
index 8040ad4c13b0..4652c90147c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -791,6 +791,7 @@ struct iwl_mvm_txq {
 	atomic_t tx_request;
 #define IWL_MVM_TXQ_STATE_STOP_FULL	0
 #define IWL_MVM_TXQ_STATE_STOP_REDIRECT	1
+#define IWL_MVM_TXQ_STATE_READY		2
 	unsigned long state;
 };
=20
@@ -938,6 +939,7 @@ struct iwl_mvm {
 		struct iwl_mvm_tvqm_txq_info tvqm_info[IWL_MAX_TVQM_QUEUES];
 	};
 	struct work_struct add_stream_wk; /* To add streams to queues */
+	spinlock_t add_stream_lock;
=20
 	const char *nvm_file_name;
 	struct iwl_nvm_data *nvm_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/ops.c
index 1a925ea9f822..aa6eb9986641 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1396,6 +1396,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const =
struct iwl_cfg *cfg,
 	INIT_DELAYED_WORK(&mvm->scan_timeout_dwork, iwl_mvm_scan_timeout_wk);
 	INIT_WORK(&mvm->add_stream_wk, iwl_mvm_add_new_dqa_stream_wk);
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
+	spin_lock_init(&mvm->add_stream_lock);
=20
 	init_waitqueue_head(&mvm->rx_sync_waitq);
=20
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/sta.c
index 5b39da622f37..bf2f3b1bc888 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -421,8 +421,11 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, st=
ruct ieee80211_sta *sta,
 		struct iwl_mvm_txq *mvmtxq =3D
 			iwl_mvm_txq_from_tid(sta, tid);
=20
-		mvmtxq->txq_id =3D IWL_MVM_INVALID_QUEUE;
+		spin_lock_bh(&mvm->add_stream_lock);
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		mvmtxq->txq_id =3D IWL_MVM_INVALID_QUEUE;
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
=20
 	/* Regardless if this is a reserved TXQ for a STA - mark it as false */
@@ -516,8 +519,11 @@ static int iwl_mvm_remove_sta_queue_marking(struct iwl=
_mvm *mvm, int queue)
 			disable_agg_tids |=3D BIT(tid);
 		mvmsta->tid_data[tid].txq_id =3D IWL_MVM_INVALID_QUEUE;
=20
-		mvmtxq->txq_id =3D IWL_MVM_INVALID_QUEUE;
+		spin_lock_bh(&mvm->add_stream_lock);
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		mvmtxq->txq_id =3D IWL_MVM_INVALID_QUEUE;
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
=20
 	mvmsta->tfd_queue_msk &=3D ~BIT(queue); /* Don't use this queue anymore *=
/
@@ -1523,12 +1529,22 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_stru=
ct *wk)
 		 * a queue in the function itself.
 		 */
 		if (iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, tid)) {
+			spin_lock_bh(&mvm->add_stream_lock);
 			list_del_init(&mvmtxq->list);
+			spin_unlock_bh(&mvm->add_stream_lock);
 			continue;
 		}
=20
-		list_del_init(&mvmtxq->list);
+		/* now we're ready, any remaining races/concurrency will be
+		 * handled in iwl_mvm_mac_itxq_xmit()
+		 */
+		set_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+
 		local_bh_disable();
+		spin_lock(&mvm->add_stream_lock);
+		list_del_init(&mvmtxq->list);
+		spin_unlock(&mvm->add_stream_lock);
+
 		iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
 		local_bh_enable();
 	}
@@ -1965,8 +1981,11 @@ static void iwl_mvm_disable_sta_queues(struct iwl_mv=
m *mvm,
 		struct iwl_mvm_txq *mvmtxq =3D
 			iwl_mvm_txq_from_mac80211(sta->txq[i]);
=20
+		spin_lock_bh(&mvm->add_stream_lock);
 		mvmtxq->txq_id =3D IWL_MVM_INVALID_QUEUE;
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
 }
=20
--=20
2.39.2


