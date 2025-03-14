Return-Path: <linux-wireless+bounces-20378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7AA60FE7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC214882B95
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4F1FDE2C;
	Fri, 14 Mar 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Gzx7nlWP";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Q9Lkrh/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F911FDA7A
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951551; cv=none; b=i/4dtiW+qCY+zJvV/tH+8DyDaJr8q2N7JaPBy/OGZlrpvTwHR1IZEPvgLpeH6tvldTj5uotVsCFrXHv22PMXwGasOeu4JOLhuqnWBfIzxbpfEjpWd/VYxFFbiO0xL8I6e8Dahf68r4qOh7myVcmT2ypRYCVz9DJh3a6t4qCoka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951551; c=relaxed/simple;
	bh=bui+sgPyzR2G8LRYmNaQRxDDZhKG5Gh4x3fA0txGOy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWwYW2DROOCjz6zO/bgUD9s/yPmduCf9KrBgmLYLwMsRRbv3FBBJM7UdqZEs9/tjYwhyCrAL9emGZkqMdLF6ApF/Ak9thbOdiScq00u25e06hAt4Vz715ApVP2ZjOwnptLxOPp3FMrkqtsw63KmYyu5HBX1WU3H9TRxWuHmXh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Gzx7nlWP; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Q9Lkrh/k; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1741950641; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Tf4BrW1vWLMedPyDJ2iLarCXnf06nMp0xpM83vTGV/w=;
 b=Gzx7nlWPUXiRV7GFE84SA8oACifiTOHZz7UScBGXAmKx2VyquXEKAKtMi61cIoBuidaFo
 Psb8q9O2qyoAjkdfr70oHxW+H0sh6moU7g2qMfKUrUakTS+5azSo2OD+PyhNl0JhA/fAPZl
 qkYi6Ihet+mdejVfT0bdxdBJOk//THX2tbdOUISomZkf+9jLAvGmmT/4KmvY/3dWX9V1S61
 s5fP0ZPF99I74D+AJ5EvEC5d35yiOlVo7aDqbjin1OfaxoD61A7+wfkvhKKnFLKAMpiCKaX
 BMFd7EFoVDn5YW5ZXhHDSlEdyfGt6wkRLuQkUbYOCkm1W+YuFqc74x1f4Wzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1741950641; h=from : subject
 : to : message-id : date;
 bh=Tf4BrW1vWLMedPyDJ2iLarCXnf06nMp0xpM83vTGV/w=;
 b=Q9Lkrh/kcv0ldNxO1RlSynp+LH0Xzw1kCYgPYZ6aE03ZuraVvyjG01v2FOtjfsZT+Udcg
 1+naRidtNxZRbKi+t7HxCVIw0CZWw9+HsJldpExeRiBu192jSLktZMLxcdU+2SZFNTVhCi4
 KQi0aqvVbfdv1SZUcBFANtOyBr0hMH85lA340RjMISAEuZy1vra6tAPYBARUtdkQVJpavFi
 d9pONV1ihs1xvXb2seU38LD7htg3NPN/U411+WhGbK1h7KvTm9Nn1V//w7hP/GCilihF2So
 jdtMv6aVevX6xcZXDw4uR+w7+O6VcKVz5f8/7YoNDbik4VpSrEBJikgGhnyQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tt2w0-FnQW0hPoaKZ-lQRB;
	Fri, 14 Mar 2025 11:10:36 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/2] wifi: mac80211: Purge vif txq in ieee80211_do_stop()
Date: Fri, 14 Mar 2025 12:04:25 +0100
Message-Id: <54c3c83ea8f58af89d275d410682d73cc6289dc8.1741950009.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1741950009.git.repk@triplefau.lt>
References: <cover.1741950009.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s0w53aj45L
X-smtpcorp-track: D3nc27VYU7tH.Wa8odZlMPFiX.r_NO_wlP4Rn

After ieee80211_do_stop() SKB from vif's txq could still be processed.
Indeed another concurrent vif schedule_and_wake_txq call could cause
those packets to be dequeued (see ieee80211_handle_wake_tx_queue())
without checking the sdata current state.

Because vif.drv_priv is now cleared in this function, this could lead to
driver crash.

For example in ath12k, ahvif is store in vif.drv_priv. Thus if
ath12k_mac_op_tx() is called after ieee80211_do_stop(), ahvif->ah can be
NULL, leading the ath12k_warn(ahvif->ah,...) call in this function to
trigger the NULL deref below.

  Unable to handle kernel paging request at virtual address dfffffc000000001
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  batman_adv: bat0: Interface deactivated: brbh1337
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [dfffffc000000001] address between user and kernel address ranges
  Internal error: Oops: 0000000096000004 [#1] SMP
  CPU: 1 UID: 0 PID: 978 Comm: lbd Not tainted 6.13.0-g633f875b8f1e #114
  Hardware name: HW (DT)
  pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : ath12k_mac_op_tx+0x6cc/0x29b8 [ath12k]
  lr : ath12k_mac_op_tx+0x174/0x29b8 [ath12k]
  sp : ffffffc086ace450
  x29: ffffffc086ace450 x28: 0000000000000000 x27: 1ffffff810d59ca4
  x26: ffffff801d05f7c0 x25: 0000000000000000 x24: 000000004000001e
  x23: ffffff8009ce4926 x22: ffffff801f9c0800 x21: ffffff801d05f7f0
  x20: ffffff8034a19f40 x19: 0000000000000000 x18: ffffff801f9c0958
  x17: ffffff800bc0a504 x16: dfffffc000000000 x15: ffffffc086ace4f8
  x14: ffffff801d05f83c x13: 0000000000000000 x12: ffffffb003a0bf03
  x11: 0000000000000000 x10: ffffffb003a0bf02 x9 : ffffff8034a19f40
  x8 : ffffff801d05f818 x7 : 1ffffff0069433dc x6 : ffffff8034a19ee0
  x5 : ffffff801d05f7f0 x4 : 0000000000000000 x3 : 0000000000000001
  x2 : 0000000000000000 x1 : dfffffc000000000 x0 : 0000000000000008
  Call trace:
   ath12k_mac_op_tx+0x6cc/0x29b8 [ath12k] (P)
   ieee80211_handle_wake_tx_queue+0x16c/0x260
   ieee80211_queue_skb+0xeec/0x1d20
   ieee80211_tx+0x200/0x2c8
   ieee80211_xmit+0x22c/0x338
   __ieee80211_subif_start_xmit+0x7e8/0xc60
   ieee80211_subif_start_xmit+0xc4/0xee0
   __ieee80211_subif_start_xmit_8023.isra.0+0x854/0x17a0
   ieee80211_subif_start_xmit_8023+0x124/0x488
   dev_hard_start_xmit+0x160/0x5a8
   __dev_queue_xmit+0x6f8/0x3120
   br_dev_queue_push_xmit+0x120/0x4a8
   __br_forward+0xe4/0x2b0
   deliver_clone+0x5c/0xd0
   br_flood+0x398/0x580
   br_dev_xmit+0x454/0x9f8
   dev_hard_start_xmit+0x160/0x5a8
   __dev_queue_xmit+0x6f8/0x3120
   ip6_finish_output2+0xc28/0x1b60
   __ip6_finish_output+0x38c/0x638
   ip6_output+0x1b4/0x338
   ip6_local_out+0x7c/0xa8
   ip6_send_skb+0x7c/0x1b0
   ip6_push_pending_frames+0x94/0xd0
   rawv6_sendmsg+0x1a98/0x2898
   inet_sendmsg+0x94/0xe0
   __sys_sendto+0x1e4/0x308
   __arm64_sys_sendto+0xc4/0x140
   do_el0_svc+0x110/0x280
   el0_svc+0x20/0x60
   el0t_64_sync_handler+0x104/0x138
   el0t_64_sync+0x154/0x158

To avoid that, empty vif's txq at ieee80211_do_stop() so no packet could
be dequeued after ieee80211_do_stop() (new packets cannot be queued
because SDATA_STATE_RUNNING is cleared at this point).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/iface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 738de269e13f..e60c1ffebaea 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -660,6 +660,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
+	if (sdata->vif.txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
-- 
2.40.0


