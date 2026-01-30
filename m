Return-Path: <linux-wireless+bounces-31389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DSVMenVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719DBC573
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E5D303DD41
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA0303A3B;
	Fri, 30 Jan 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlV6mjiK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pqccz6cO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EA3446A5
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788868; cv=none; b=fBjCohP6MIU6uOfNMyiwbNjTadoxNX4/07fsS9gJu+E3xsdsLr8afIGzHOvOQNhuHmbIFVSFZfAtdcwD3KGLvhIne6GSV0M/XDAXz6RZD6HM0ZZCkOvX1iX4dUiie2MmVnB9vGaQXecjmLZbpyCdJcDXjzBFCYWp9NcMjwPHszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788868; c=relaxed/simple;
	bh=2CE7va60BGZmGmCqF+VOg+sfA33EUBnOBVgt/BwJZM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwNsGrku6ekDzqHT+VERFa/WEuuI1ZkpqZ2K3yeqNXItuhtmmvRUP3yYYlKFUQ/SMwoTfMJOp3IwGapJR9s212mnGs6F8uYDaAAFHib4CgBrKCvBL+ia7M1l1NaZgX+SyIvW0JqqnoiNCWnPXOjxsTjfDrko7ay7zJOZP8yJ5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlV6mjiK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pqccz6cO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAoLBT486064
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Xc495iUHo3u
	WMYhaUvvQrFklJ8gPyz8PjoZa/ug9vug=; b=AlV6mjiKG569DPiAP+kcKBwwlo/
	rdoKM6M7uI9ekRQTsoZBXsB2dEYrz3lnczPfghr27jm+zSUnJsUkNipBDp6Ihjox
	uRVc221ftmejzWCiPMbzxM1bshtgUr9skDExff3r55qFcZObIrfUYbxXbainp5eC
	JVOeHdUVnHsYCmV1+7fqUji8e9Ni0F8hb9jBkN9BIvbwp3fJqja3CXpQanr2xJIg
	jgvIazU2rVtyeYlvysyJFmCerOVM/I2XBvACzxrq2kE6AGrwPq8Q6FQ8kr0G5BKD
	3PylAFWeZ5Ht3baaeWweyCP0O90FPTK1li/WGj/s9LHUKMVX1EYp96V6WXw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtnjrjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso1296646a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788865; x=1770393665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc495iUHo3uWMYhaUvvQrFklJ8gPyz8PjoZa/ug9vug=;
        b=Pqccz6cOgbWhw/GOQPzOUPhQkghdnJrJcIDnOHWEnj0/VnkBKjDAz9idaP/HDldlTm
         qFhV9pLkrYf5K48r2zL0EvnNckKGj1yqE8uUe/l1BDfpvAAEPZVpD3kQjie/RRuw3Bgm
         LGD4imYBCfcEthhhUfwZrGT25IbqWwvqFvmWMLoXGLivasTm/V2a7PnWd4Zlgm/9MNsR
         0ZeUa3nr3Df9ypVkC1Wx3RV9FlCNtLu7mG8Vw7ZmNgn4He500X4LsPiV6nLJWBUiAlDX
         g44lYZSZ58s5BZG3y/UCydVLoKBLGUOJsC1OZ9ANRsgbQK/Tj7c1D/IigE7LCsqvKuaV
         XW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788865; x=1770393665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xc495iUHo3uWMYhaUvvQrFklJ8gPyz8PjoZa/ug9vug=;
        b=ulOJuuwCvqua2xXtK/sBGUrp0bfzn95hGLSi4h4nM3G34HbQW11pmHDL4zr+muKvtZ
         0pmCupphxcCwf+UPH8FYzgYwyWJeJAIPgeB5suTooWfpCHspyWMhazLkZIY+2OhZ3JHO
         ClAUf5Pesc/OBeiCJwJkQtIXYLpnNA2psdDCa7MNqefJRPhnehUU1v0t7gmFTt7oZjl5
         Th0crapQBmjfvdFpioQOvG6sS0gCo0skqEcMJxEqdRm36IZ9e88l2z9TWfqt1puSRrep
         P8NbPogLwUiQmxiSOD5op0aemrUzNmOnN5G5tp8Hm3c5Qi9nh/ma38DyJg2iz27n0f3d
         ByWg==
X-Gm-Message-State: AOJu0YylRqCYDwH7JlZTUhRf7NmExoIUxdmZDqA3mv3siZZSMB0cw/DZ
	I+jblSck1pylL2Tsa9WqB0v7qt2ly2qi/Py4c8wv4jdgYzZrzAexbdBn1SgPNVy/O8ZYAQF7ipv
	h+p4hxZHU8HDwUVWxuqNOSqAcvi7BqPItxyfrP0aarb7jsV4SXss1G9YUrm1dCrLYp9Ga5+f7cn
	oW
X-Gm-Gg: AZuq6aLpiCoEDEU10BGNWqYgtC+cH6bWfwUEMso8degy3iN1Px5ZQV0AnXFF/1KJ/66
	n0aRWon6plTncCLGePEbTg5ZaxEeCVqGhTEy85DM9DEAZKQGemF8Iqb+2R4DnDbpmvqNODUsNBC
	6FSh2EWzPusSRZhVTU2ulbzfKKGCx0amVlfUg1ueW2ao/dpJtcx98nfB7PSXsditfVrOrmZvak2
	Te1ZLkRZvm3gWtw9kaRChpojAOPkWusd3g0mJJySKe6xqS5lq6ymJuV+dn/8yVf0pgi0UqoLecL
	wOMVjKtenGZ+2A26oeFfWIh4RlD7GHW9eg4/C4KLFK+31uupZ2NTzlzeB0YOZAskQWCr3rE/vbZ
	gyZb0vPPukJDReTAOhAVtpPwDgBHLLlzuHZuegMGPvKA=
X-Received: by 2002:a05:6a21:3286:b0:38e:87b6:a00a with SMTP id adf61e73a8af0-392e014b50cmr2825747637.55.1769788864865;
        Fri, 30 Jan 2026 08:01:04 -0800 (PST)
X-Received: by 2002:a05:6a21:3286:b0:38e:87b6:a00a with SMTP id adf61e73a8af0-392e014b50cmr2825674637.55.1769788863859;
        Fri, 30 Jan 2026 08:01:03 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:03 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/13] wifi: nl80211/cfg80211: add peer measurement abort command
Date: Fri, 30 Jan 2026 21:30:31 +0530
Message-Id: <20260130160039.2823409-6-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DXGBUQTt9ivc1dUPaP8VTiT0FdNICl38
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697cd5c2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=G1p9uJ5VPZ1gOx4JwssA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: DXGBUQTt9ivc1dUPaP8VTiT0FdNICl38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX7HNWSrTlyTai
 0mj4j75McIZfNh9qdNqrLSijDncKJwYiofNT+twA11U2bVqmTOY7jXo9MDdAWvqGe115bmwx/Pd
 /JnhJFlHOLlheE1/sNfBUW2Xs9WprYNklLximAaUCw6XcscGSicceyTFdHT1vjWf/O9Has8QGb0
 b3m9tlXWHPVjQutFI5aBXYn2htV05om6rt7eZchSfKTuqlECwSxV+Mgvb+Q73WFsrpoeKVI7gY7
 cjZ95umTc4DXIuWg7hAP94HYHwN8w1qHFD0ssj2XGc9bYYHBrFaJvV6bp0X6U2HSGKTG8IZMCZ6
 CyJGMR9pqicqcb39D8ieK+itzDBoTru2CzT9gw0lyDFif3DZh8fbkHX8W3GRHSTlspjGYtl857G
 EFb26mrqes9ZszBFSeZP7Rhsimw3PEE7R1HgflDNgel63PTW+0UwY2GDN7HsTStWcyJEe4eEG5R
 bXsrCycf2Ej9thKZMqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31389-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2719DBC573
X-Rspamd-Action: no action

Add support for aborting ongoing peer measurement sessions
through a new NL80211_CMD_PEER_MEASUREMENT_ABORT command.
This allows userspace to cancel continuous ranging or other
long-running measurement sessions before completion.

The abort operation is identified by the measurement cookie.
When a matching request is found, it is marked for cleanup
and the existing free work is scheduled to handle the
abortion and notify the driver.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       |  6 ++++++
 net/wireless/nl80211.h       |  1 +
 net/wireless/pmsr.c          | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a3c82b231d82..b2410d4f572c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1361,6 +1361,9 @@
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
  *
+ * @NL80211_CMD_PEER_MEASUREMENT_ABORT: Abort an ongoing peer measurement,
+ *     identified by %NL80211_ATTR_COOKIE.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1624,6 +1627,8 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_PEER_MEASUREMENT_ABORT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e0c910d22bd4..1ad7eb103189 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19117,6 +19117,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_PEER_MEASUREMENT_ABORT,
+		.doit = nl80211_pmsr_abort,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 5e25782af1e0..9791da9f5fbd 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -123,6 +123,7 @@ void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce);
 
 /* peer measurement */
 int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info);
+int nl80211_pmsr_abort(struct sk_buff *skb, struct genl_info *info);
 
 void nl80211_mlo_reconf_add_done(struct net_device *dev,
 				 struct cfg80211_mlo_reconf_done_data *data);
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 141ac19f86c8..8b7665f2f824 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -718,6 +718,40 @@ void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
 	WARN_ON(!list_empty(&wdev->pmsr_list));
 }
 
+int nl80211_pmsr_abort(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct cfg80211_pmsr_request *req;
+	u64 cookie;
+
+	if (!rdev->wiphy.pmsr_capa)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_COOKIE])
+		return -EINVAL;
+
+	cookie = nla_get_u64(info->attrs[NL80211_ATTR_COOKIE]);
+
+	spin_lock_bh(&wdev->pmsr_lock);
+	list_for_each_entry(req, &wdev->pmsr_list, list) {
+		if (req->cookie == cookie) {
+			/* Verify the request belongs to this netlink port */
+			if (req->nl_portid != info->snd_portid) {
+				spin_unlock_bh(&wdev->pmsr_lock);
+				return -EACCES;
+			}
+			req->nl_portid = 0; /* Mark for abortion */
+			schedule_work(&wdev->pmsr_free_wk);
+			spin_unlock_bh(&wdev->pmsr_lock);
+			return 0;
+		}
+	}
+	spin_unlock_bh(&wdev->pmsr_lock);
+
+	return -ENOENT; /* Request not found */
+}
+
 void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid)
 {
 	struct cfg80211_pmsr_request *req;
-- 
2.34.1


