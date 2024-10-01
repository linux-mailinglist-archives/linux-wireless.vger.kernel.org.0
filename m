Return-Path: <linux-wireless+bounces-13373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2398BBA9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9EB237F6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0B1C1755;
	Tue,  1 Oct 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oeiuehif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CC1C174A;
	Tue,  1 Oct 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783817; cv=none; b=ayK7Neh00veiArRgFeo9nfgCgrwgkQ/IzcN7Ie1WFNfzgYaV0PnXaU7LFk+C7ytlD03PpNCzlGEkV93dVtcLQa9u5hCe0eJYxHHlQTY/MCADfsuuLPiWLI4OAz61TeCmWnv3i09I/nEA+sb4z+wraMXTpSWS3Jky6M8TVRfT0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783817; c=relaxed/simple;
	bh=jm3VWk83nPa7H9FvbWeVvZ/R23DWoJibr7imv4M6GlE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Hh9X9rhNbZQwohywVgQiANeHR5zgPiWPa1YvVRHlKMRBk91Lg+ed0MlCv9Xdn7vwMKLWAslnaELg+/2Vdmtw5MlclwNB0u5ce/MBWVFE7oQQeFv7FWlExgZ2j0VyuQ8XI9XFoSjaI4uY1UwxaM5kJ8ItaxFUzOdcTKxgtbV89Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oeiuehif; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727783788; x=1728388588; i=markus.elfring@web.de;
	bh=3e8bkKCVqm+SsiEA9CKci4eqGjzjQ0+wNEOsn7FxGJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oeiuehifYPB+uM1Y4kYDMH9vUkgNfZpZkjLTdqNg+7HXOjsnBFQ8rsgC7zXVVE8u
	 qiGC+7Dx99nWUeE/MF6UO1VjTLKx3FAYFPwjKZWRu9x9x6wF+oCTveWSZOmfZVCwN
	 Ynw/6EpsWVEkkW3Ln8Aq1BQZKMMztnt8BsvDcnSjrJE586V/T8k3cCPQtu59adp8D
	 9MJ8NE7SJDyFASDjXHYLCOCTuywimoszmIpJ9bwAAB5yHV3EAImQU5ztOm5A43TVv
	 ERvL9jn+PWiY9oeUYjmvfmmPlzpMa4xA1b8VClKvSab2ghze//sB+LGH/PJJ2o2t0
	 ofE1ap54ZVtoDE5wJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1sVNUa3IPf-00QhjI; Tue, 01
 Oct 2024 13:56:27 +0200
Message-ID: <45074762-ce4b-4eaa-9e41-965a6da0a59c@web.de>
Date: Tue, 1 Oct 2024 13:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Simon Horman <horms@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] wifi: ath: Use common kfree() code in 53 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yciOZViKVc9zBzW2H5fwEAewDf5c+zSl9c7lI5GQGrDY0lh6swR
 cwApGvrF4vwNRdL93IAsfDiLUioP6PLvWUMXlu0s96CXyYFhiSYvvl4UNh50fRdVsDrfc7Y
 FxbbAGZzSm+ckexKWc0ptkGnm5kMbV2d2nDp5y88vVjdhzYKZaNrXgeEPPHvNQoHbPorAuX
 BKGcKBSxbwx/tXNJk9I5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zgixpsLapKA=;4RgqoAwMZEcw8JJfHC161toG1DP
 izKJeApLXgwylJvJbeVZS6/WaPvM/9JFXMYBBVCKYK+q8E0xJCdI6ea+Q0H9pMAxd2rSkHkMw
 5vsKMR/Potmo8HAOxOQVqr6A+erI/l2wCx5Wbcew9N0FBMxsfu1J5jSn1Wzk0KUzmEoFlLsKw
 ZAg6vANJ94csTMeVzZxwBkslSv3pRCKdGyIrD4MttvLRJt5fzwymfSFdOl5Zn/J2rMTVssuNZ
 ZFxFLls/Lwg8kcZssHFEZEcVDs9gQO+7AxOfQoK/pb3ypt/LDCelLJisc1s3uKdcPVC0XqafG
 cjWK/OKOF/SRQXcXq12cZV8PXtNqL4Y3/mxPRpBvphJqTXHrWdZs2YYD/V3KKB5nnRiGOoDR+
 iUmuc0v1x7jIpOg+uiRtW18rrXTTFrfQdIYJl73W3dRlFEwRFqLXrOepAAOrsQy890kn58hHL
 SBxL6i6mm8WC2LsjTQD5buIJnN0nscAmH17eKj8KwydYQKgPvhEbQDHt2PxNI5OH3VCAJ621u
 q7nNHiWvwjIal6r/abeyy0IbB/broNmedq5iqYAw5LfubhFogOd4k3HDFtmfFj/LmjcXIeb7V
 zk220jzszyZu1Dr4w+n0NsNKK2Iw0xIwqC+YcmU3bZI23ul1pW0xSfr7+1PAYH3nVANPkFhVq
 NBi4g4tfbDMO/yv9w3TCMxIsQjnmZ/HwPcdhaHCx7m3L4MopTPdsUEFOIGP3kfmwDTEuhx012
 tvQsmLvwiAuL9df6jiP5/nqiu09GsAHlOfh543FCLYSlZEkXNlbsW6HU7v1+MbxKOSZtJCHd3
 T4fNR3sx8YWmJe85O6GRUibA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 1 Oct 2024 13:38:27 +0200

Add a label so that a bit of exception handling can be better reused
at the end of 53 function implementations.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/ath10k/bmi.c     |   7 +-
 drivers/net/wireless/ath/ath10k/usb.c     |  15 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 170 +++++++++++---------
 drivers/net/wireless/ath/ath11k/wmi.c     | 179 ++++++++++++----------
 drivers/net/wireless/ath/ath12k/wmi.c     | 166 +++++++++++---------
 drivers/net/wireless/ath/ath6kl/usb.c     |  15 +-
 6 files changed, 306 insertions(+), 246 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/=
ath/ath10k/bmi.c
index 9a4f8e815412..01715ba4309f 100644
=2D-- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -375,17 +375,18 @@ static int ath10k_bmi_lz_data_large(struct ath10k *a=
r, const void *buffer, u32 l
 						  NULL, NULL);
 		if (ret) {
 			ath10k_warn(ar, "unable to write to the device\n");
-			kfree(cmd);
-			return ret;
+			goto free_cmd;
 		}

 		buffer +=3D txlen;
 		length -=3D txlen;
 	}

+	ret =3D 0;
+free_cmd:
 	kfree(cmd);

-	return 0;
+	return ret;
 }

 int ath10k_bmi_lz_data(struct ath10k *ar, const void *buffer, u32 length)
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/=
ath/ath10k/usb.c
index 3b51b7f52130..b4ef0fdae144 100644
=2D-- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -504,13 +504,14 @@ static int ath10k_usb_submit_ctrl_out(struct ath10k =
*ar,
 	if (ret < 0) {
 		ath10k_warn(ar, "Failed to submit usb control message: %d\n",
 			    ret);
-		kfree(buf);
-		return ret;
+		goto free_buf;
 	}

+	ret =3D 0;
+free_buf:
 	kfree(buf);

-	return 0;
+	return ret;
 }

 static int ath10k_usb_submit_ctrl_in(struct ath10k *ar,
@@ -538,15 +539,15 @@ static int ath10k_usb_submit_ctrl_in(struct ath10k *=
ar,
 	if (ret < 0) {
 		ath10k_warn(ar, "Failed to read usb control message: %d\n",
 			    ret);
-		kfree(buf);
-		return ret;
+		goto free_buf;
 	}

 	memcpy((u8 *)data, buf, size);
-
+	ret =3D 0;
+free_buf:
 	kfree(buf);

-	return 0;
+	return ret;
 }

 static int ath10k_usb_ctrl_msg_exchange(struct ath10k *ar,
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wirel=
ess/ath/ath10k/wmi-tlv.c
index dbaf26d6a7a6..87c4573e923f 100644
=2D-- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -184,8 +184,8 @@ static int ath10k_wmi_tlv_event_bcn_tx_status(struct a=
th10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_OFFLOAD_BCN_TX_STATUS_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	tx_status =3D __le32_to_cpu(ev->tx_status);
@@ -209,8 +209,10 @@ static int ath10k_wmi_tlv_event_bcn_tx_status(struct =
ath10k *ar,
 	if (arvif && arvif->is_up && arvif->vif->bss_conf.csa_active)
 		ieee80211_queue_work(ar->hw, &arvif->ap_csa_work);

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath10k_wmi_tlv_event_vdev_delete_resp(struct ath10k *ar,
@@ -279,8 +281,8 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(stru=
ct ath10k *ar,
 	data =3D tb[WMI_TLV_TAG_ARRAY_STRUCT];

 	if (!ev || !data) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	num_peer_stats =3D __le32_to_cpu(ev->num_peers);
@@ -296,8 +298,10 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(str=
uct ath10k *ar,
 	if (ret)
 		ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath10k_wmi_tlv_event_peer_stats_info(struct ath10k *ar,
@@ -327,8 +331,8 @@ static int ath10k_wmi_tlv_event_diag_data(struct ath10=
k *ar,
 	ev =3D tb[WMI_TLV_TAG_STRUCT_DIAG_DATA_CONTAINER_EVENT];
 	data =3D tb[WMI_TLV_TAG_ARRAY_BYTE];
 	if (!ev || !data) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	num_items =3D __le32_to_cpu(ev->num_items);
@@ -367,8 +371,10 @@ static int ath10k_wmi_tlv_event_diag_data(struct ath1=
0k *ar,
 		ath10k_warn(ar, "failed to parse diag data event: num_items %d len %d\n=
",
 			    num_items, len);

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_event_diag(struct ath10k *ar,
@@ -387,16 +393,17 @@ static int ath10k_wmi_tlv_event_diag(struct ath10k *=
ar,

 	data =3D tb[WMI_TLV_TAG_ARRAY_BYTE];
 	if (!data) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}
 	len =3D ath10k_wmi_tlv_len(data);

 	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi tlv diag event len %d\n", len);
 	trace_ath10k_wmi_diag(ar, data, len);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_event_p2p_noa(struct ath10k *ar,
@@ -418,8 +425,8 @@ static int ath10k_wmi_tlv_event_p2p_noa(struct ath10k =
*ar,
 	noa =3D tb[WMI_TLV_TAG_STRUCT_P2P_NOA_INFO];

 	if (!ev || !noa) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	vdev_id =3D __le32_to_cpu(ev->vdev_id);
@@ -429,8 +436,10 @@ static int ath10k_wmi_tlv_event_p2p_noa(struct ath10k=
 *ar,
 		   vdev_id, noa->num_descriptors);

 	ath10k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_event_tx_pause(struct ath10k *ar,
@@ -450,8 +459,8 @@ static int ath10k_wmi_tlv_event_tx_pause(struct ath10k=
 *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_TX_PAUSE_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	pause_id =3D __le32_to_cpu(ev->pause_id);
@@ -494,8 +503,10 @@ static int ath10k_wmi_tlv_event_tx_pause(struct ath10=
k *ar,
 		break;
 	}

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath10k_wmi_tlv_event_rfkill_state_change(struct ath10k *ar,
@@ -821,8 +832,8 @@ static int ath10k_wmi_tlv_op_pull_scan_ev(struct ath10=
k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_SCAN_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->event_type =3D ev->event_type;
@@ -831,9 +842,10 @@ static int ath10k_wmi_tlv_op_pull_scan_ev(struct ath1=
0k *ar,
 	arg->scan_req_id =3D ev->scan_req_id;
 	arg->scan_id =3D ev->scan_id;
 	arg->vdev_id =3D ev->vdev_id;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -853,8 +865,8 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k =
*ar, struct sk_buff *skb,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->desc_id =3D ev->desc_id;
@@ -865,8 +877,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k=
 *ar, struct sk_buff *skb,
 	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map))
 		arg->ack_rssi =3D ev->ack_rssi;

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 struct wmi_tlv_tx_bundle_compl_parse {
@@ -963,8 +977,8 @@ static int ath10k_wmi_tlv_op_pull_mgmt_rx_ev(struct at=
h10k *ar,
 	frame =3D tb[WMI_TLV_TAG_ARRAY_BYTE];

 	if (!ev || !frame) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->channel =3D ev->channel;
@@ -980,8 +994,8 @@ static int ath10k_wmi_tlv_op_pull_mgmt_rx_ev(struct at=
h10k *ar,
 	msdu_len =3D __le32_to_cpu(arg->buf_len);

 	if (skb->len < (frame - skb->data) + msdu_len) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	/* shift the sk_buff to point to `frame` */
@@ -989,9 +1003,10 @@ static int ath10k_wmi_tlv_op_pull_mgmt_rx_ev(struct =
ath10k *ar,
 	skb_put(skb, frame - skb->data);
 	skb_pull(skb, frame - skb->data);
 	skb_put(skb, msdu_len);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_op_pull_ch_info_ev(struct ath10k *ar,
@@ -1011,8 +1026,8 @@ static int ath10k_wmi_tlv_op_pull_ch_info_ev(struct =
ath10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_CHAN_INFO_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->err_code =3D ev->err_code;
@@ -1025,8 +1040,10 @@ static int ath10k_wmi_tlv_op_pull_ch_info_ev(struct=
 ath10k *ar,
 		     ar->running_fw->fw_file.fw_features))
 		arg->mac_clk_mhz =3D ev->mac_clk_mhz;

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -1046,8 +1063,8 @@ ath10k_wmi_tlv_op_pull_vdev_start_ev(struct ath10k *=
ar, struct sk_buff *skb,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_VDEV_START_RESPONSE_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	skb_pull(skb, sizeof(*ev));
@@ -1055,9 +1072,10 @@ ath10k_wmi_tlv_op_pull_vdev_start_ev(struct ath10k =
*ar, struct sk_buff *skb,
 	arg->req_id =3D ev->req_id;
 	arg->resp_type =3D ev->resp_type;
 	arg->status =3D ev->status;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_op_pull_peer_kick_ev(struct ath10k *ar,
@@ -1077,14 +1095,15 @@ static int ath10k_wmi_tlv_op_pull_peer_kick_ev(str=
uct ath10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_PEER_STA_KICKOUT_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->mac_addr =3D ev->peer_macaddr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 struct wmi_tlv_swba_parse {
@@ -1227,8 +1246,8 @@ static int ath10k_wmi_tlv_op_pull_phyerr_ev_hdr(stru=
ct ath10k *ar,
 	phyerrs =3D tb[WMI_TLV_TAG_ARRAY_BYTE];

 	if (!ev || !phyerrs) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->num_phyerrs  =3D __le32_to_cpu(ev->num_phyerrs);
@@ -1236,9 +1255,10 @@ static int ath10k_wmi_tlv_op_pull_phyerr_ev_hdr(str=
uct ath10k *ar,
 	arg->tsf_u32 =3D __le32_to_cpu(ev->tsf_u32);
 	arg->buf_len =3D __le32_to_cpu(ev->buf_len);
 	arg->phyerrs =3D phyerrs;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 #define WMI_TLV_ABI_VER_NS0 0x5F414351
@@ -1402,17 +1422,18 @@ static int ath10k_wmi_tlv_op_pull_rdy_ev(struct at=
h10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_READY_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->sw_version =3D ev->abi.abi_ver0;
 	arg->abi_version =3D ev->abi.abi_ver1;
 	arg->status =3D ev->status;
 	arg->mac_addr =3D ev->mac_addr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16=
 len,
@@ -1515,8 +1536,8 @@ static int ath10k_wmi_tlv_op_pull_fw_stats(struct at=
h10k *ar,
 	data =3D tb[WMI_TLV_TAG_ARRAY_BYTE];

 	if (!ev || !data) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	data_len =3D ath10k_wmi_tlv_len(data);
@@ -1539,8 +1560,8 @@ static int ath10k_wmi_tlv_op_pull_fw_stats(struct at=
h10k *ar,

 		src =3D data;
 		if (data_len < sizeof(*src)) {
-			kfree(tb);
-			return -EPROTO;
+			ret =3D -EPROTO;
+			goto free_tb;
 		}

 		data +=3D sizeof(*src);
@@ -1562,8 +1583,8 @@ static int ath10k_wmi_tlv_op_pull_fw_stats(struct at=
h10k *ar,

 		src =3D data;
 		if (data_len < sizeof(*src)) {
-			kfree(tb);
-			return -EPROTO;
+			ret =3D -EPROTO;
+			goto free_tb;
 		}

 		data +=3D sizeof(*src);
@@ -1583,8 +1604,8 @@ static int ath10k_wmi_tlv_op_pull_fw_stats(struct at=
h10k *ar,

 		src =3D data;
 		if (data_len < sizeof(*src)) {
-			kfree(tb);
-			return -EPROTO;
+			ret =3D -EPROTO;
+			goto free_tb;
 		}

 		data +=3D sizeof(*src);
@@ -1621,8 +1642,10 @@ static int ath10k_wmi_tlv_op_pull_fw_stats(struct a=
th10k *ar,
 		list_add_tail(&dst->list, &stats->peers);
 	}

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_op_pull_roam_ev(struct ath10k *ar,
@@ -1642,16 +1665,17 @@ static int ath10k_wmi_tlv_op_pull_roam_ev(struct a=
th10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_ROAM_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->vdev_id =3D ev->vdev_id;
 	arg->reason =3D ev->reason;
 	arg->rssi =3D ev->rssi;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -1671,17 +1695,18 @@ ath10k_wmi_tlv_op_pull_wow_ev(struct ath10k *ar, s=
truct sk_buff *skb,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_WOW_EVENT_INFO];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->vdev_id =3D __le32_to_cpu(ev->vdev_id);
 	arg->flag =3D __le32_to_cpu(ev->flag);
 	arg->wake_reason =3D __le32_to_cpu(ev->wake_reason);
 	arg->data_len =3D __le32_to_cpu(ev->data_len);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath10k_wmi_tlv_op_pull_echo_ev(struct ath10k *ar,
@@ -1701,14 +1726,15 @@ static int ath10k_wmi_tlv_op_pull_echo_ev(struct a=
th10k *ar,

 	ev =3D tb[WMI_TLV_TAG_STRUCT_ECHO_EVENT];
 	if (!ev) {
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->value =3D ev->value;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static struct sk_buff *
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/=
ath/ath11k/wmi.c
index 87abfa547529..5ce507b49d20 100644
=2D-- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5130,8 +5130,8 @@ static int ath11k_pull_vdev_start_resp_tlv(struct at=
h11k_base *ab, struct sk_buf
 	ev =3D tb[WMI_TAG_VDEV_START_RESPONSE_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch vdev start resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	memset(vdev_rsp, 0, sizeof(*vdev_rsp));
@@ -5146,9 +5146,10 @@ static int ath11k_pull_vdev_start_resp_tlv(struct a=
th11k_base *ab, struct sk_buf
 	vdev_rsp->cfgd_tx_streams =3D ev->cfgd_tx_streams;
 	vdev_rsp->cfgd_rx_streams =3D ev->cfgd_rx_streams;
 	vdev_rsp->max_allowed_tx_power =3D ev->max_allowed_tx_power;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath11k_print_reg_rule(struct ath11k_base *ab, const char *ban=
d,
@@ -5230,8 +5231,8 @@ static int ath11k_pull_reg_chan_list_update_ev(struc=
t ath11k_base *ab,
 	chan_list_event_hdr =3D tb[WMI_TAG_REG_CHAN_LIST_CC_EVENT];
 	if (!chan_list_event_hdr) {
 		ath11k_warn(ab, "failed to fetch reg chan list update ev\n");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	reg_info->num_2ghz_reg_rules =3D chan_list_event_hdr->num_2ghz_reg_rules=
;
@@ -5239,8 +5240,8 @@ static int ath11k_pull_reg_chan_list_update_ev(struc=
t ath11k_base *ab,

 	if (!(reg_info->num_2ghz_reg_rules + reg_info->num_5ghz_reg_rules)) {
 		ath11k_warn(ab, "No regulatory rules available in the event info\n");
-		kfree(tb);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto free_tb;
 	}

 	memcpy(reg_info->alpha2, &chan_list_event_hdr->alpha2,
@@ -5289,9 +5290,9 @@ static int ath11k_pull_reg_chan_list_update_ev(struc=
t ath11k_base *ab,
 				create_reg_rules_from_wmi(num_2ghz_reg_rules,
 							  wmi_reg_rule);
 		if (!reg_info->reg_rules_2ghz_ptr) {
-			kfree(tb);
 			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ath11k_print_reg_rule(ab, "2 GHz",
@@ -5305,9 +5306,9 @@ static int ath11k_pull_reg_chan_list_update_ev(struc=
t ath11k_base *ab,
 				create_reg_rules_from_wmi(num_5ghz_reg_rules,
 							  wmi_reg_rule);
 		if (!reg_info->reg_rules_5ghz_ptr) {
-			kfree(tb);
 			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ath11k_print_reg_rule(ab, "5 GHz",
@@ -5316,9 +5317,10 @@ static int ath11k_pull_reg_chan_list_update_ev(stru=
ct ath11k_base *ab,
 	}

 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory channel list\n");
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static struct cur_reg_rule
@@ -5406,8 +5408,8 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 	ev =3D tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch reg chan list ext update ev\n");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	reg_info->num_2ghz_reg_rules =3D ev->num_2ghz_reg_rules;
@@ -5438,8 +5440,8 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 	    (num_5ghz_reg_rules > MAX_REG_RULES)) {
 		ath11k_warn(ab, "Num reg rules for 2.4 GHz/5 GHz exceeds max limit (num=
_2ghz_reg_rules: %d num_5ghz_reg_rules: %d max_rules: %d)\n",
 			    num_2ghz_reg_rules, num_5ghz_reg_rules, MAX_REG_RULES);
-		kfree(tb);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto free_tb;
 	}

 	for (i =3D 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
@@ -5448,8 +5450,8 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 		if (num_6ghz_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
 			ath11k_warn(ab, "Num 6 GHz reg rules for AP mode(%d) exceeds max limit=
 (num_6ghz_reg_rules_ap: %d, max_rules: %d)\n",
 				    i, num_6ghz_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
-			kfree(tb);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto free_tb;
 		}

 		total_reg_rules +=3D num_6ghz_reg_rules_ap[i];
@@ -5476,15 +5478,15 @@ static int ath11k_pull_reg_chan_list_ext_update_ev=
(struct ath11k_base *ab,
 			ath11k_warn(ab,
 				    "Num 6 GHz client reg rules exceeds max limit, for client(type: %=
d)\n",
 				    i);
-			kfree(tb);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto free_tb;
 		}
 	}

 	if (!total_reg_rules) {
 		ath11k_warn(ab, "No reg rules available\n");
-		kfree(tb);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto free_tb;
 	}

 	memcpy(reg_info->alpha2, &ev->alpha2, REG_ALPHA2_LEN);
@@ -5597,9 +5599,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_2ghz_ptr) {
-			kfree(tb);
 			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ath11k_print_reg_rule(ab, "2 GHz",
@@ -5636,9 +5638,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_5ghz_ptr) {
-			kfree(tb);
 			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ath11k_print_reg_rule(ab, "5 GHz",
@@ -5659,9 +5661,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_6ghz_ap_ptr[i]) {
-			kfree(tb);
 			ath11k_warn(ab, "Unable to Allocate memory for 6 GHz AP rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ath11k_print_reg_rule(ab, ath11k_6ghz_ap_type_to_str(i),
@@ -5681,9 +5683,9 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(s=
truct ath11k_base *ab,
 							      ext_wmi_reg_rule);

 			if (!reg_info->reg_rules_6ghz_client_ptr[j][i]) {
-				kfree(tb);
 				ath11k_warn(ab, "Unable to Allocate memory for 6 GHz client rules\n")=
;
-				return -ENOMEM;
+				ret =3D -ENOMEM;
+				goto free_tb;
 			}

 			ath11k_print_reg_rule(ab,
@@ -5740,9 +5742,10 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(=
struct ath11k_base *ab,
 		   ath11k_super_reg_6ghz_to_str(reg_info->domain_code_6ghz_super_id));

 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processed regulatory ext channel list\n"=
);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_peer_del_resp_ev(struct ath11k_base *ab, struct sk=
_buff *skb,
@@ -5762,8 +5765,8 @@ static int ath11k_pull_peer_del_resp_ev(struct ath11=
k_base *ab, struct sk_buff *
 	ev =3D tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch peer delete resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	memset(peer_del_resp, 0, sizeof(*peer_del_resp));
@@ -5771,9 +5774,10 @@ static int ath11k_pull_peer_del_resp_ev(struct ath1=
1k_base *ab, struct sk_buff *
 	peer_del_resp->vdev_id =3D ev->vdev_id;
 	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
 			ev->peer_macaddr.addr);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_vdev_del_resp_ev(struct ath11k_base *ab,
@@ -5794,14 +5798,15 @@ static int ath11k_pull_vdev_del_resp_ev(struct ath=
11k_base *ab,
 	ev =3D tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch vdev delete resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id =3D ev->vdev_id;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_bcn_tx_status_ev(struct ath11k_base *ab,
@@ -5822,15 +5827,16 @@ static int ath11k_pull_bcn_tx_status_ev(struct ath=
11k_base *ab,
 	ev =3D tb[WMI_TAG_OFFLOAD_BCN_TX_STATUS_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch bcn tx status ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id   =3D ev->vdev_id;
 	*tx_status =3D ev->tx_status;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_vdev_stopped_param_tlv(struct ath11k_base *ab, str=
uct sk_buff *skb,
@@ -5850,14 +5856,15 @@ static int ath11k_pull_vdev_stopped_param_tlv(stru=
ct ath11k_base *ab, struct sk_
 	ev =3D tb[WMI_TAG_VDEV_STOPPED_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch vdev stop ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id =3D  ev->vdev_id;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_wmi_tlv_mgmt_rx_parse(struct ath11k_base *ab,
@@ -6004,17 +6011,18 @@ static int ath11k_pull_mgmt_tx_compl_param_tlv(str=
uct ath11k_base *ab,
 	ev =3D tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch mgmt tx compl ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	param->pdev_id =3D ev->pdev_id;
 	param->desc_id =3D ev->desc_id;
 	param->status =3D ev->status;
 	param->ack_rssi =3D ev->ack_rssi;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath11k_wmi_event_scan_started(struct ath11k *ar)
@@ -6180,8 +6188,8 @@ static int ath11k_pull_scan_ev(struct ath11k_base *a=
b, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_SCAN_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch scan ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	scan_evt_param->event_type =3D ev->event_type;
@@ -6191,9 +6199,10 @@ static int ath11k_pull_scan_ev(struct ath11k_base *=
ab, struct sk_buff *skb,
 	scan_evt_param->scan_id =3D ev->scan_id;
 	scan_evt_param->vdev_id =3D ev->vdev_id;
 	scan_evt_param->tsf_timestamp =3D ev->tsf_timestamp;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_peer_sta_kickout_ev(struct ath11k_base *ab, struct=
 sk_buff *skb,
@@ -6213,14 +6222,15 @@ static int ath11k_pull_peer_sta_kickout_ev(struct =
ath11k_base *ab, struct sk_buf
 	ev =3D tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch peer sta kickout ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->mac_addr =3D ev->peer_macaddr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_roam_ev(struct ath11k_base *ab, struct sk_buff *sk=
b,
@@ -6240,16 +6250,17 @@ static int ath11k_pull_roam_ev(struct ath11k_base =
*ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_ROAM_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch roam ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	roam_ev->vdev_id =3D ev->vdev_id;
 	roam_ev->reason =3D ev->reason;
 	roam_ev->rssi =3D ev->rssi;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int freq_to_idx(struct ath11k *ar, int freq)
@@ -6288,8 +6299,8 @@ static int ath11k_pull_chan_info_ev(struct ath11k_ba=
se *ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch chan info ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	ch_info_ev->err_code =3D ev->err_code;
@@ -6304,9 +6315,10 @@ static int ath11k_pull_chan_info_ev(struct ath11k_b=
ase *ab, struct sk_buff *skb,
 	ch_info_ev->tx_frame_cnt =3D ev->tx_frame_cnt;
 	ch_info_ev->mac_clk_mhz =3D ev->mac_clk_mhz;
 	ch_info_ev->vdev_id =3D ev->vdev_id;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -6327,8 +6339,8 @@ ath11k_pull_pdev_bss_chan_info_ev(struct ath11k_base=
 *ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch pdev bss chan info ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	bss_ch_info_ev->pdev_id =3D ev->pdev_id;
@@ -6344,9 +6356,10 @@ ath11k_pull_pdev_bss_chan_info_ev(struct ath11k_bas=
e *ab, struct sk_buff *skb,
 	bss_ch_info_ev->rx_cycle_count_high =3D ev->rx_cycle_count_high;
 	bss_ch_info_ev->rx_bss_cycle_count_low =3D ev->rx_bss_cycle_count_low;
 	bss_ch_info_ev->rx_bss_cycle_count_high =3D ev->rx_bss_cycle_count_high;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -6367,8 +6380,8 @@ ath11k_pull_vdev_install_key_compl_ev(struct ath11k_=
base *ab, struct sk_buff *sk
 	ev =3D tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch vdev install key compl ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->vdev_id =3D ev->vdev_id;
@@ -6376,9 +6389,10 @@ ath11k_pull_vdev_install_key_compl_ev(struct ath11k=
_base *ab, struct sk_buff *sk
 	arg->key_idx =3D ev->key_idx;
 	arg->key_flags =3D ev->key_flags;
 	arg->status =3D ev->status;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath11k_pull_peer_assoc_conf_ev(struct ath11k_base *ab, struct =
sk_buff *skb,
@@ -6398,15 +6412,16 @@ static int ath11k_pull_peer_assoc_conf_ev(struct a=
th11k_base *ab, struct sk_buff
 	ev =3D tb[WMI_TAG_PEER_ASSOC_CONF_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch peer assoc conf ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	peer_assoc_conf->vdev_id =3D ev->vdev_id;
 	peer_assoc_conf->macaddr =3D ev->peer_macaddr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath11k_wmi_pull_pdev_stats_base(const struct wmi_pdev_stats_b=
ase *src,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/=
ath/ath12k/wmi.c
index 190439ad7f23..c4578be1676e 100644
=2D-- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4628,14 +4628,15 @@ static int ath12k_pull_vdev_start_resp_tlv(struct =
ath12k_base *ab, struct sk_buf
 	ev =3D tb[WMI_TAG_VDEV_START_RESPONSE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev start resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_rsp =3D *ev;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static struct ath12k_reg_rule
@@ -4706,8 +4707,8 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 	ev =3D tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch reg chan list ext update ev\n");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	reg_info->num_2g_reg_rules =3D le32_to_cpu(ev->num_2g_reg_rules);
@@ -4736,8 +4737,8 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 	if (num_2g_reg_rules > MAX_REG_RULES || num_5g_reg_rules > MAX_REG_RULES=
) {
 		ath12k_warn(ab, "Num reg rules for 2G/5G exceeds max limit (num_2g_reg_=
rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
 			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
-		kfree(tb);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto free_tb;
 	}

 	for (i =3D 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
@@ -4746,8 +4747,8 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 		if (num_6g_reg_rules_ap[i] > MAX_6G_REG_RULES) {
 			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (n=
um_6g_reg_rules_ap: %d, max_rules: %d)\n",
 				    i, num_6g_reg_rules_ap[i], MAX_6G_REG_RULES);
-			kfree(tb);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto free_tb;
 		}

 		total_reg_rules +=3D num_6g_reg_rules_ap[i];
@@ -4771,15 +4772,15 @@ static int ath12k_pull_reg_chan_list_ext_update_ev=
(struct ath12k_base *ab,
 		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6G_REG_RULES) {
 			ath12k_warn(ab, "Num 6g client reg rules exceeds max limit, for client=
(type: %d)\n",
 				    i);
-			kfree(tb);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto free_tb;
 		}
 	}

 	if (!total_reg_rules) {
 		ath12k_warn(ab, "No reg rules available\n");
-		kfree(tb);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto free_tb;
 	}

 	memcpy(reg_info->alpha2, &ev->alpha2, REG_ALPHA2_LEN);
@@ -4894,9 +4895,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_2g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}
 	}

@@ -4907,9 +4908,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_5g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}
 	}

@@ -4921,9 +4922,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 						      ext_wmi_reg_rule);

 		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 6g ap rules\n");
-			return -ENOMEM;
+			ret =3D -ENOMEM;
+			goto free_tb;
 		}

 		ext_wmi_reg_rule +=3D num_6g_reg_rules_ap[i];
@@ -4936,9 +4937,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(s=
truct ath12k_base *ab,
 							      ext_wmi_reg_rule);

 			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
-				kfree(tb);
 				ath12k_warn(ab, "Unable to Allocate memory for 6g client rules\n");
-				return -ENOMEM;
+				ret =3D -ENOMEM;
+				goto free_tb;
 			}

 			ext_wmi_reg_rule +=3D num_6g_reg_rules_cl[j][i];
@@ -4970,9 +4971,10 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(=
struct ath12k_base *ab,
 		   reg_info->client_type, reg_info->domain_code_6g_super_id);

 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n"=
);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk=
_buff *skb,
@@ -4992,8 +4994,8 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12=
k_base *ab, struct sk_buff *
 	ev =3D tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer delete resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	memset(peer_del_resp, 0, sizeof(*peer_del_resp));
@@ -5001,9 +5003,10 @@ static int ath12k_pull_peer_del_resp_ev(struct ath1=
2k_base *ab, struct sk_buff *
 	peer_del_resp->vdev_id =3D ev->vdev_id;
 	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
 			ev->peer_macaddr.addr);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
@@ -5024,14 +5027,15 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath=
12k_base *ab,
 	ev =3D tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev delete resp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id =3D le32_to_cpu(ev->vdev_id);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
@@ -5052,15 +5056,16 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath=
12k_base *ab,
 	ev =3D tb[WMI_TAG_OFFLOAD_BCN_TX_STATUS_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch bcn tx status ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id =3D le32_to_cpu(ev->vdev_id);
 	*tx_status =3D le32_to_cpu(ev->tx_status);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, str=
uct sk_buff *skb,
@@ -5080,14 +5085,15 @@ static int ath12k_pull_vdev_stopped_param_tlv(stru=
ct ath12k_base *ab, struct sk_
 	ev =3D tb[WMI_TAG_VDEV_STOPPED_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev stop ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	*vdev_id =3D le32_to_cpu(ev->vdev_id);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_wmi_tlv_mgmt_rx_parse(struct ath12k_base *ab,
@@ -5224,16 +5230,17 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(str=
uct ath12k_base *ab,
 	ev =3D tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch mgmt tx compl ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	param->pdev_id =3D ev->pdev_id;
 	param->desc_id =3D ev->desc_id;
 	param->status =3D ev->status;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath12k_wmi_event_scan_started(struct ath12k *ar)
@@ -5405,8 +5412,8 @@ static int ath12k_pull_scan_ev(struct ath12k_base *a=
b, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_SCAN_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch scan ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	scan_evt_param->event_type =3D ev->event_type;
@@ -5416,9 +5423,10 @@ static int ath12k_pull_scan_ev(struct ath12k_base *=
ab, struct sk_buff *skb,
 	scan_evt_param->scan_id =3D ev->scan_id;
 	scan_evt_param->vdev_id =3D ev->vdev_id;
 	scan_evt_param->tsf_timestamp =3D ev->tsf_timestamp;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct=
 sk_buff *skb,
@@ -5438,14 +5446,15 @@ static int ath12k_pull_peer_sta_kickout_ev(struct =
ath12k_base *ab, struct sk_buf
 	ev =3D tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer sta kickout ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->mac_addr =3D ev->peer_macaddr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *sk=
b,
@@ -5465,16 +5474,17 @@ static int ath12k_pull_roam_ev(struct ath12k_base =
*ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_ROAM_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch roam ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	roam_ev->vdev_id =3D ev->vdev_id;
 	roam_ev->reason =3D ev->reason;
 	roam_ev->rssi =3D ev->rssi;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int freq_to_idx(struct ath12k *ar, int freq)
@@ -5517,8 +5527,8 @@ static int ath12k_pull_chan_info_ev(struct ath12k_ba=
se *ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch chan info ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	ch_info_ev->err_code =3D ev->err_code;
@@ -5533,9 +5543,10 @@ static int ath12k_pull_chan_info_ev(struct ath12k_b=
ase *ab, struct sk_buff *skb,
 	ch_info_ev->tx_frame_cnt =3D ev->tx_frame_cnt;
 	ch_info_ev->mac_clk_mhz =3D ev->mac_clk_mhz;
 	ch_info_ev->vdev_id =3D ev->vdev_id;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -5556,8 +5567,8 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base=
 *ab, struct sk_buff *skb,
 	ev =3D tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev bss chan info ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	bss_ch_info_ev->pdev_id =3D ev->pdev_id;
@@ -5573,9 +5584,10 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_bas=
e *ab, struct sk_buff *skb,
 	bss_ch_info_ev->rx_cycle_count_high =3D ev->rx_cycle_count_high;
 	bss_ch_info_ev->rx_bss_cycle_count_low =3D ev->rx_bss_cycle_count_low;
 	bss_ch_info_ev->rx_bss_cycle_count_high =3D ev->rx_bss_cycle_count_high;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -5596,8 +5608,8 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_=
base *ab, struct sk_buff *sk
 	ev =3D tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev install key compl ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	arg->vdev_id =3D le32_to_cpu(ev->vdev_id);
@@ -5605,9 +5617,10 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k=
_base *ab, struct sk_buff *sk
 	arg->key_idx =3D le32_to_cpu(ev->key_idx);
 	arg->key_flags =3D le32_to_cpu(ev->key_flags);
 	arg->status =3D le32_to_cpu(ev->status);
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct =
sk_buff *skb,
@@ -5627,15 +5640,16 @@ static int ath12k_pull_peer_assoc_conf_ev(struct a=
th12k_base *ab, struct sk_buff
 	ev =3D tb[WMI_TAG_PEER_ASSOC_CONF_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer assoc conf ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

 	peer_assoc_conf->vdev_id =3D le32_to_cpu(ev->vdev_id);
 	peer_assoc_conf->macaddr =3D ev->peer_macaddr.addr;
-
+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static int
@@ -5655,12 +5669,14 @@ ath12k_pull_pdev_temp_ev(struct ath12k_base *ab, s=
truct sk_buff *skb,
 	ev =3D tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev temp ev");
-		kfree(tb);
-		return -EPROTO;
+		ret =3D -EPROTO;
+		goto free_tb;
 	}

+	ret =3D 0;
+free_tb:
 	kfree(tb);
-	return 0;
+	return ret;
 }

 static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/=
ath/ath6kl/usb.c
index 5220809841a6..ea27eb535a02 100644
=2D-- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -892,13 +892,14 @@ static int ath6kl_usb_submit_ctrl_out(struct ath6kl_=
usb *ar_usb,

 	if (ret < 0) {
 		ath6kl_warn("Failed to submit usb control message: %d\n", ret);
-		kfree(buf);
-		return ret;
+		goto free_buf;
 	}

+	ret =3D 0;
+free_buf:
 	kfree(buf);

-	return 0;
+	return ret;
 }

 static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
@@ -924,15 +925,15 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_u=
sb *ar_usb,

 	if (ret < 0) {
 		ath6kl_warn("Failed to read usb control message: %d\n", ret);
-		kfree(buf);
-		return ret;
+		goto free_buf;
 	}

 	memcpy((u8 *) data, buf, size);
-
+	ret =3D 0;
+free_buf:
 	kfree(buf);

-	return 0;
+	return ret;
 }

 static int ath6kl_usb_ctrl_msg_exchange(struct ath6kl_usb *ar_usb,
=2D-
2.46.1


