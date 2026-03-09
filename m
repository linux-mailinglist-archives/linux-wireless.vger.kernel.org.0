Return-Path: <linux-wireless+bounces-32785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH9vLi1Tr2m/UAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:09:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DE24292B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7313177B68
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2283BA24D;
	Mon,  9 Mar 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaYhT6ey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heE5DFLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929D426EA0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097557; cv=none; b=lfxNNbHZout0TA0ghHHSXEL2oPP8DRqZY4KmfQv5B6lWjw3a2EZg+awwXCfvo/T/fXp0HShEiXdMCTc3By3FOeHtedeP4nhZ3pCZ0ONoir1eNTGoK7/x30hV3ehtB1joIVhUtbmhpBcW54d44d20xQQs3vLYpCjeBdqF8BxcEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097557; c=relaxed/simple;
	bh=ulxSsa7188EBz+8PhYCrmatbVk0Sh+N5SiDD0XnhX7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdCnNo1xsT7Q81Bj7346kuiu1krpO21Pqah/KlE637cDY90nNNXbh5tO0rUF0XZWFnpJJ8OrLnJvkIzi+YqYqgg3EIDAJWahFpZL0DjJCepzXtJX3NOS9DC0yfaC9Gt+0GOVrkycSvMaOSKURhHeieHM13w2oqLaRb7agpoheZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaYhT6ey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heE5DFLZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HCDXx2428709
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 23:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/gz4Ge3MHwk
	UDTTkujrW9dZ+6p+ProQlBVOR/K4PwRg=; b=PaYhT6eylqd83bpMQFYbYaV0W5S
	mkzH1MgbfuAvBJ/7ojSkvwmB2brtv9Dy0UGX8UfrUnxTxvdkTdNan6OUS2+NvZ3e
	sF4nS+5Yv9L3QfuMDCsD6Y+UAuJmb43YTmwqFS/Gys81rzF0MMxK7v08rJZhdA1b
	WV2fQRVJm2zf+akHmBl5+inla5z3FhhzRUmrUlgsAKzOM7bgrX6B1OO3v2UxpUMA
	AYOSjkMi2Tv+TU2zS8pwaDgeJpYWAu2pVQBaPXzhjOTfhZ+VLz3I6w89RDpVfuLp
	GxB1r5AI7dmq8fbxWWH/M/nZkJFhPG1GwJ7GLHTCooGJvaSAAf/y037ZHYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct1eks918-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 23:05:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd77e5e187so1438802185a.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097555; x=1773702355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gz4Ge3MHwkUDTTkujrW9dZ+6p+ProQlBVOR/K4PwRg=;
        b=heE5DFLZZBFfzHQy57r9wHCcM5YyZkfzpeXU2HCzt/OvFiUW/GmmCMHNUKMFHibU9c
         yP4bGFgz/mapyRq735LKe9UDNwcX1Sm3nJhW8scXKUSJvK+xYC6O1p2h/Sh746jQfc9f
         8dU9JpiWIOplw9CKZL4pUEe4UWJ1vC1lMybwsRSMqBQqCMFgU6f9IGs+f6urSWiIYHzu
         yi/zvoGtPs+CGXb6QOZDdISu7Bt9YXMJ1EgEhNevR+KEvdK/S72EbScaUAZYCWCbyfUN
         U3J3ya5ezlxjBm5Y6GZ1D9s4eVEZrJBI9YDE7oP7FprjG9WvTGPmjW85bODcPm/CXPem
         OjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097555; x=1773702355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gz4Ge3MHwkUDTTkujrW9dZ+6p+ProQlBVOR/K4PwRg=;
        b=H+CZFK2Rb/oc94sUy6unCvs/tmJIPha/1ts58urtAlUOoj7rY3xHMuu3AOJ/XW/KQX
         0Sqd9r5rQjteeXSVmLRhzsBULXdMV4Sl5t2fPsBns11q5ufor6uNXLXLa4h1Ys5UI5oJ
         +daiN5s6liUHba2WcYxq8mZXT3L2iok6qdGMwTnLUGXm52lVbgsXubuouqLOlyS6T0eo
         +9DFog4AQy3AqFkz7XPU2NYCL/6ad1Z8mqbZS/h/vcHoVpen1qN0tGPpEIwdfJm6wBvv
         TyEvn7Ph9wbUdOImhyqpicoO3FLXidYCE+3yWjq6Aww/0tUcWC5jrQTGk6QfTecuveoz
         EphQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDFWwjbMdvxhftnwm4XGBSa+UFZgAN5hLVLPHrUgiESuLMTKxLWVV4JSIywfKMSotL6sRG/du/5eOvIDk6XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzigeO1xEjl/xoGQMaWJR2rOTxy+/+8nefPReV/thjT+QM5hKT
	HQWJHCPro2lehcLaNGUZ5HuRhmofSl5lJiUEbl9nlwbEDp9qKYhKCTVbJ/zcY2xCd9l5EGDenn1
	P/HSmlW6Lvgm9aL+zM3e9iYwuEegdEfcSWOXeoEpQ9ADBkSTp9uJBwz9cLJVJXU7W7ZMUZQ==
X-Gm-Gg: ATEYQzzMuBd49w8js+oh4zO6+LAmPO37QU7PyMPov4vVvf69BMa2joOshyIsk2+dZQ2
	yN6xryXglvsvZYgvoj3zo7t56HTvFDBq7AubifAEAOlpQ2AxOI2qAzCwd9H24rGes3DycUVHk9E
	ihQgyFwZczTdVr7L/qF/1bDiSTPOliNUTrxd6bOJ6KBMmUCbStEqVZ2GxRte+/WSt+/u2FA8W7R
	19GjueQ0vD/RA6r3TX+yWykvJoKGEx048I/uJ8AZUp4xOvSrMNz9LtUU8g7O8PXZtqS50h/+BBg
	Rfy7koeFcb9OLp5Dc1XdLgO+tyyhjB6Emo33S6IxQaUUVgblZHWaME6GqlXB1yEFQi7pfzO6l+y
	hbRgKqlibhfAwyyHbkNTZc1PEPDCJ0DG++JCWULMHz2wu1FoABw==
X-Received: by 2002:a05:620a:1728:b0:8cd:8e8c:2076 with SMTP id af79cd13be357-8cd8e8c242dmr439789985a.77.1773097554736;
        Mon, 09 Mar 2026 16:05:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1728:b0:8cd:8e8c:2076 with SMTP id af79cd13be357-8cd8e8c242dmr439783485a.77.1773097554104;
        Mon, 09 Mar 2026 16:05:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:53 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: konradybcio@kernel.org, andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: [PATCH v1 5/8] slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:34 +0100
Message-ID: <20260309230346.3584252-6-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oz1iHEcHInpRLJLzpAhkzEecunvJGZQO
X-Proofpoint-ORIG-GUID: oz1iHEcHInpRLJLzpAhkzEecunvJGZQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXxnBFg8oHqNGI
 vFO+4WiDZk5s5cH9/trGm4JLHZrQ35NvTOfo92bcppIagEjsSZqfsK7Mg3sKZ7xRLrr9ZnWr3VI
 2XlQVguRqtj6uLI5tT8IKsXuXODLpOdKZI7pjqeZovroBQOBB6iDaOJvsQMpNnjrFqq6n3ReWsK
 eqALhRpwSCl9YckhjO94HWXZBG2KqwF1qFoqe/sdBKgJLfRRfhU4zI59Hp8jYuvxnZqKbMxZQJP
 18TJBma5qbNnog0nFPb6H9JPR9Vgbc57mRGgr9wA8nyugzfOe5uFcFLr8LHOuU/osC64nTilG9X
 SQ9+JNbZZDsd8KY6j3X5iYpQ5vFSx/h1Ae6xzt0KcQf98KhO1s809AjIRRx9JSsJBYoQ7V8v/k7
 pJ09LK8YfQD3CpoSdew+XCjDlX8uFNG5WjqkpPrCBp+L4LQKxXec+VeLFOexKcndDm5SJvr/99M
 hoi8iUfNh0QWfNBXgRg==
X-Authority-Analysis: v=2.4 cv=eIEeTXp1 c=1 sm=1 tr=0 ts=69af5253 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=PhtMypRRY1SmXJO8NnMA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: 680DE24292B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32785-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 9aa7218b4e8d..0b88b8577bdb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -48,7 +48,6 @@
 				NGD_INT_RX_MSG_RCVD)
 
 /* Slimbus QMI service */
-#define SLIMBUS_QMI_SVC_ID	0x0301
 #define SLIMBUS_QMI_SVC_V1	1
 #define SLIMBUS_QMI_INS_ID	0
 #define SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01	0x0020
@@ -1408,8 +1407,8 @@ static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_ctrl *ctrl)
 		return ret;
 	}
 
-	ret = qmi_add_lookup(&qmi->svc_event_hdl, SLIMBUS_QMI_SVC_ID,
-			SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
+	ret = qmi_add_lookup(&qmi->svc_event_hdl, QMI_SERVICE_ID_SLIMBUS,
+			     SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
 	if (ret < 0) {
 		dev_err(ctrl->dev, "qmi_add_lookup failed: %d\n", ret);
 		qmi_handle_release(&qmi->svc_event_hdl);
-- 
2.43.0


