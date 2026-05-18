Return-Path: <linux-wireless+bounces-36597-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C07GpDsCmo89gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36597-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:40:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C30AC56AD4D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C21F3024105
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADD3EDAB9;
	Mon, 18 May 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dhhw4Lz5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kF8fSU3h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A453ED114
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100293; cv=none; b=T3spHJXSOwH4OiffrE1qefDGmiWm/N1iiq6D74YVp9F/IuiC8ItRW5qjJ7Rje9jCD/KxsbpUe1irVlTGP5vNtZ7baTf/H9QTMbz2KiLxhiBLVdu9yI076SxekUmgo5O3Byj1Nq+Ko+MQvL76i4SZdAooUwNCf1l0HPBZuwWnBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100293; c=relaxed/simple;
	bh=XGuKjmjrdRYD8Hzddl+eLlemEV5gwR29fayRSwiJum4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Op2Rzd4lPuBU3cN0jeMSgTjFVaN1jePnS9B5Ln3MUhkccDmxBRlBL96lRBesJbNeyi6avnmW+NT2uKwUnZHrAnV5ADc5CaDf6X0oI6op+SqG0xJYRghscvCTh5jnWggiLf7chYEKlpP4iwm+P7vwZCov6EWvhLWzGR/RtHwU/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dhhw4Lz5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kF8fSU3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7fjYk2189450
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fNhRY8+/bR4
	nJS0grtSiCy2zaI//jOXpMzGUkhOAVZ0=; b=Dhhw4Lz5KI+hN05wVTw+HujLlRk
	PEWhojPezGfTMxnWDCTjWERLfQ6vl6pev+8rxZXc7+vljauOHgJ1f19pg30Pt0uI
	lHgEfR34R4fcyliiWNe1RbcMAcfB1OjSbUKYlcAOQIRNwAmwlSkF8Vjjh1o+D+n6
	NSa3nHsU9XzlSvLsT+tAkZUq1l+VR97dogIZiW7EljnhsMknUbsz7C5coBlk8yE8
	vnbrmPTesXpmFRqYuHn74i4KpSrfkX69sjgBKC8xXKNOiyxb0XcNpg3w/tM3FqF0
	0rJefHzaWEfx0FwW0cdnf5Thm2sAQY6dDZCXmdhSZG0YYQhgBDOJM6SXN6Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xkugqjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso1115049a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779100277; x=1779705077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNhRY8+/bR4nJS0grtSiCy2zaI//jOXpMzGUkhOAVZ0=;
        b=kF8fSU3h6hnMhMiD5vqiY0sDIYEA0PffFz0ucuF49K7OYkKNWtFliSmnAHNlZtCPuM
         DVja/VimrmQh4sKkM0TBP4HGPUhYBFYIEZN7duva19PItb3wi1iFH0fz9U17vFUc7htL
         q0gCMLmaMDTVVrFACXBZ+xNo1oiS4/EfA3IqPFaP9RGCFBsZsqT6wYmXQbPBv5pFL6di
         ujcZAY/dIU8azNwRzqLDFtgmT/yqRVcMqG0bXnih1O5vrgxJNKuJQMmbslcIUTISWR+K
         VezXenra+sRINLdc3E1fOfeX/ZmWd7itZuKrtLQ1ByOKYn3RbThqXYQPp8e8SsQ08MRm
         0aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100277; x=1779705077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNhRY8+/bR4nJS0grtSiCy2zaI//jOXpMzGUkhOAVZ0=;
        b=Yx3tiI9MqqD/+2pfnVx4M2FYVPa1K+X+cnuJhxYHPhC5uHqlGZJLkLQgJR74rwcJLg
         PsprKoevlFL/eYSTSx6tsvaNnr1v0E7lnEodUEWXvD0wg7wUrOTeJ66k/R26iYOWTRWN
         BK2GQrgADteP7N4dKczzCRu7nNGTDgMi3PtjgV74bL4nBWK0ImoZxtP/UJLs3Su1U4f/
         peWqgEvROTZd6E/tlQRA67SQxQWvZ6wUbLaHoxeE4/CeMieP+fuZAZq2eaVzLgH3HyxJ
         YZoZppvbaMDjsvuPt61rJRxlHSSQjWSn4yrvjN/PqwNSsKJmEd9Mv3bphazVM1oUXvy5
         yWCw==
X-Gm-Message-State: AOJu0Yx8+elNBwLdA50d2Hw6lDb+wPAMqjMvvX0REnQ0YSbRIpHDB6oD
	rWhiv2oipMhFQNk4LJyhZV0pE7mn6hxVJEZuIXI2uAdbCArTX2dHkkwbvbP3fIOvkf+iEwXxZ2T
	kQLF8de1T6bbeEbdljloBEpPb1HNyhe+ItNcOlhiNpYP9HrjmWnVx6/hHR3WABOoV2gRM
X-Gm-Gg: Acq92OGRa6Q0pYtsYLKe/H+MCdU6xAoZ3Cj96yfVDeyBCzgeZV7YcYa2BIavqCaqats
	THhGXlp/UmWOROj79QqxZLmd5uHEqhKHjaR2blKt6q7LHox5t2mn1j5fNxfCHVlyC9p5DQLANTE
	coX9X8ayTElb/zjP2T17nLWCDD0CVeb7FeMj8MAbLWGNyDX4Zt7N2xCiDeZsQBVNxiHsg1oOfTQ
	+8LypBRA8rHJdB7Yy5o0zi9Cg9hg8uEpCfJ30zHY9cAmc0XRKUX2I7cYfJjm4EcnNRK326td/Xs
	09WbiMFyUpHq1JzhKfLDxc2Eeyk8pqmNGff9iSQw8iTKGISeyO8wHvdKQxVJGZsh/ERfkeOLWEW
	a4KEiR6EbrIRw+3yTu47h9i9fxEFyiGk6aYaWimzHgAKrB8xfERFbqG258NNgAOWHq38ehdlJhf
	fxY8cj4XYbZWNsutD98CxWzMjdjsOWnKGyFl8mmIVEmou6LMY=
X-Received: by 2002:a05:6a00:1904:b0:839:12a7:70f7 with SMTP id d2e1a72fcca58-83f33d94ce8mr14850553b3a.31.1779100276911;
        Mon, 18 May 2026 03:31:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:1904:b0:839:12a7:70f7 with SMTP id d2e1a72fcca58-83f33d94ce8mr14850520b3a.31.1779100276398;
        Mon, 18 May 2026 03:31:16 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19775ca3sm15107597b3a.14.2026.05.18.03.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:31:16 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, vikram@qti.qualcomm.com,
        kiranv@qti.qualcomm.com, pshashik@qti.qualcomm.com,
        cgopi@qti.qualcomm.com, ybasamma@qti.qualcomm.com,
        vthiagar@qti.qualcomm.com, sivad@qti.qualcomm.com,
        uvignesh@qti.qualcomm.com, mohathan@qti.qualcomm.com,
        abishekg@qti.qualcomm.com
Subject: [PATCH wireless-next 1/2] wifi: nl80211: Add NL80211_ATTR_MAX_CH_SWITCH_TIME attribute
Date: Mon, 18 May 2026 16:01:05 +0530
Message-Id: <20260518103106.1462604-2-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
References: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwMSBTYWx0ZWRfX/WvoltBFz0ph
 x4o4BV2JHhiI9rfwH+m/yGCqsL/I8yeOX+li7YJj/iUsxfr0beqE8l8gWkbp4sCI5Dtzx4W7Ekd
 6pWcbrFu6/7c0ywMVuKPFpOLIWK4b5SLFAKY5bLLUEumWE8JPbpZ9Fnzw5rDSg3JUODLI50o6ta
 lO+z83eJII0oIbZf0A/KbRdNhHciDdmKugNhgE9gFgQwQ1qU2Q0kOVF1WPWh8Kq+beJrqZtPFy1
 BiToWxkrUb40QoHxyjPAALIapFoxPRAIGQ8cgYTW13tVfW2TaKYoqCTEqkxPy0cLIxe9zLkdbLG
 WETqVQkLOxTZBx33GQ2erJDRp9mDpM398VoxQllxEe11wNCjnLT8FXnRaQTgzQL7wuB4UyKdkFK
 6yAJQXrolZH40vUe59MpRYpUFlaoNUjh2BX15hibyhA2dALWjzWyZp+E7SqveQSTza3JzqT0omc
 kJiPOH/n0daBHemoATw==
X-Proofpoint-GUID: ZMs0ym-LHvSuqj0ndv1rZHjitd1M4pAl
X-Proofpoint-ORIG-GUID: ZMs0ym-LHvSuqj0ndv1rZHjitd1M4pAl
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=6a0aea75 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=IzhiUX0hILMTxzPMbFsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180101
X-Rspamd-Queue-Id: C30AC56AD4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36597-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Chandru Gopi <cgopi@qti.qualcomm.com>

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.

Add a new u32 nl80211 attribute, NL80211_ATTR_MAX_CH_SWITCH_TIME,
to carry this value in the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY
event. Userspace can use this information to decide whether to
remain connected or disconnect before the AP moves to the new
channel.

Signed-off-by: Chandru Gopi <cgopi@qti.qualcomm.com>
Signed-off-by: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/nl80211.c       |  1 +
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9998f6c0a665..65c04e1e54b6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -953,6 +953,10 @@
  *	after %NL80211_ATTR_CH_SWITCH_COUNT TBTT's.  The userspace may
  *	decide to react to this indication by requesting other
  *	interfaces to change channel as well.
+ *	%NL80211_ATTR_MAX_CH_SWITCH_TIME included in this command indicates the
+ *	AP's Max Channel Switch Time. Userspace can use this information to
+ *	decide whether to remain connected or disconnect before the AP moves to
+ *	the new channel.
  *
  * @NL80211_CMD_START_P2P_DEVICE: Start the given P2P Device, identified by
  *	its %NL80211_ATTR_WDEV identifier. It must have been created with
@@ -3165,6 +3169,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_NPCA_PRIMARY_FREQ: NPCA primary channel (u32)
  * @NL80211_ATTR_NPCA_PUNCT_BITMAP: NPCA puncturing bitmap (u32)
  *
+ * @NL80211_ATTR_MAX_CH_SWITCH_TIME: u32 attribute carrying the Switch Time
+ *	field from the MCST (Max Channel Switch Time) element, indicating the
+ *	time delta between the time the last beacon is transmitted by the AP in
+ *	the current channel and the expected time of the first beacon
+ *	transmitted by the AP in the new channel, expressed in TUs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3763,6 +3773,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_NPCA_PRIMARY_FREQ,
 	NL80211_ATTR_NPCA_PUNCT_BITMAP,
 
+	NL80211_ATTR_MAX_CH_SWITCH_TIME,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c272a2fbad03..14d41142cf79 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1093,6 +1093,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NPCA_PRIMARY_FREQ] = { .type = NLA_U32 },
 	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
+	[NL80211_ATTR_MAX_CH_SWITCH_TIME] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
-- 
2.34.1


