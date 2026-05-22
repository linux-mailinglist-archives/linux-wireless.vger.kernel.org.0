Return-Path: <linux-wireless+bounces-36796-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAA8GwQrEGo1UgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36796-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:08:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C45165B1B39
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FCF304B68C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317633AFAE3;
	Fri, 22 May 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMMVqtwj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cXmhSJUE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C73C5DBB
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444070; cv=none; b=U0quTFiUSQ8/EUaNIufQ/wXAZjg5/ZSAjKw4KHqRuPBtzs26DtPHi0zWDWf8FxxD4H4qu3tWv/JOvbyo6m7Nu278HK20O9QVjVo+kG/S1WbS1BTkrRQHJAJX8jBRwt30RzSOIoMyR3dwSJCRd8s9KQZTmFNiODawDMvSi27Ghz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444070; c=relaxed/simple;
	bh=UBj9I2ZVbQBtANcm1Eq+93YFWtxJuvyInNBweC3+uv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqsLmXtBWOgPBCHJS7bOwWatnkmypTLo9F9hRYUv5bip8BzFQeN4Khv0JKbI6tk5hxadCu6o2gsQMrGVlZevlTGesDqis7mkWMKi8d7lnUPBU7ZcP+k6L3B/QkTggzDbWLtcNkaVh63KIycoDaF+FWfDz25pseSMMvlX7iEOHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMMVqtwj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXmhSJUE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9wANA313001
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=; b=DMMVqtwjFUO5A5ba
	PHXzJrQrW4s5dtoZxgR7e7xc12CAp2Oy8N8Bu3nWnTUq4D7z4ueSCSwOMEt6J6dD
	DGCS1vxxT3Tib9zmxfd0MqOjRP5eH3aBdloXsnXT9iKYvSLZn+iD64amHlA8wJ8J
	SehF/RkyLz71llNTdyhXDbqcdoX9dUZgLvLewrciT9iIQM+1UKwFv/KR7lIB5pOg
	neAzKnI5KVnD2g3fq9+/XgSbcfzd4RZ1hroGzJBj8xONyNiGA0gEM2mUatzUtZ6n
	zXVd2DU9llaqbnAEOK1cTg1EmxMndtF5+/G7Fckskq0e4WM4ghJvZCl+en1SVJrW
	HPFEYg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88338rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso4463014b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444066; x=1780048866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=;
        b=cXmhSJUEfmEZkiTPf1/+CaGfIndBTdOBf4vt6DiFR+Et2oenw52illtsS7vyxcaDt3
         on1RF9eCUAj/Sxl2zIsNagxrXIwjXZonaIm04Hz6Y5tqCEbx7Nq65Uwi/Kfq51q936oR
         6GC5IYI3rYT+hWtwXgKb4ITJupGZXBDbKy3KrnF/0IhhTe77Y3zazCMbd6pW0r262AOF
         wJHDDT+mFqXH5pqQr1bP0UJzp3uajOZ0TLuLrOiYzwG2x70hcmwTKRxMjwp12ufmxZPD
         hSX7689Hw85gibt1vLToY3De09eSuxN8IeMhGZXzgUbVu6lIyIPjkioxHhfs7Uvz2gdJ
         Zp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444066; x=1780048866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=;
        b=lX8jWzD+b5UpKL+WH2xy8WTyq1xaho4gjG5ZSwdai1dXtzeI2G2t/naJAmHaOv/Goq
         fIeHQD2gccEmrH1oQOczmHOCeEjsUytiT9Zp+1Oz9mQA03zGXHo862gzKP1c/Jf6hUaX
         QkBbCMrgdsTgUIOuKro0Nw/0iq3P5JRVdpOvq8UzRTPIge/uG4C+eubcjtYyichpJ2vF
         Vje6h8Ydou84/bl4uIG2XpF+r3l5SEgH2quXMZoDUKgSdKR8AIhGFoS1IRPidn+SjKe6
         rjrg1Yd/jPWwwna5utAVUG1jCx1HAI195CTX+EXApDHajaAvor9pxXnDwBgbGgzi5SU3
         golA==
X-Forwarded-Encrypted: i=1; AFNElJ+/opmoJ/9DIOPJaQXq8l9G+ZkOoED9syl9aL+YqJVlywQ45cnp2ah+B2ezowI+bqLLseojEk47ElUeu/drtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdMb8HY42vjJQ77ZbBpei5Z+FndxE6DMQUUFiS8pKt2Df1iY3
	weEt2DXFFwJKjsGxJtET9OUpfrElCTFIxIZP9KAjrocKRtSncbF7YRUfnpW/JV+eiDnRgdElZVw
	Ah/64Q7JFwkbzA/XaeMI32mRuJIoaZsA5bJrM2X0hovROKi0iaEAr8L7vs1nlmaO/DA75Bg==
X-Gm-Gg: Acq92OGztaChpaVdKscyEbbaFKEVSJLfdQshCSQE119n/dgzQ6d2stDZBeCGaOc7fvS
	0vEjUgZ/v8IL8gflX1cadjLyukgcfvi8Mfdmbk57mGo2SkyJepwxD6eV0Rtei7AA+cKTk7IZOBi
	39Ut1yRCOmPa6Wifx/WIhFS54a4vkLudYPj0eFm+ix06a2w7WQ99tYCym81cDSnEBiid0Btq2yu
	Bxc9twZTsqamH6WZ4RRJGPidkdkyVl+eEOvzf3oc92BaJ1B4n92idULBlwdkLVXNHpStb8lmXlh
	weBOzxuOIDxE79ZN+sFrUKvj5Rf5hFMR+H0FjoKVbvwqD0CXscMWZHTGmxWMvy6+JjdlxR39jqO
	X4ZE5IA6bGw4PfyzJL5N0c4ZPmNQIrwMtHXrsonRmiVhDcWuk925g9YtZ
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-8415f66c854mr3352505b3a.30.1779444066250;
        Fri, 22 May 2026 03:01:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-8415f66c854mr3352459b3a.30.1779444065675;
        Fri, 22 May 2026 03:01:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:33 +0530
Subject: [PATCH v2 2/6] bus: mhi: Drop controller runtime PM callback
 indirection
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=7368;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=UBj9I2ZVbQBtANcm1Eq+93YFWtxJuvyInNBweC3+uv4=;
 b=guQyGJqG4mutdLlQ1ChKaWEf2g1AbTVPnm7d7mM85MeEF+AFm5bB3tofJI+ZSZEhBZZl45OeD
 YNohaHam4p7DV60pWefjYxjri5JSGcRQkh5MsvyEpd1J63k03Al+5Aa
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfXwl5SIsL+r+m8
 eGiOwQOLWP++vejj9fa5QKf2iuYQAlHs6YKD6vdUeY8XBKGgT0ukjUfiNYCNCmjmJmKBicv/Uu2
 zmcWCeloh+ISEpPQ9yFaeLJT0eYePit4RjxNX6SZCvdHcA5U8iA1rfEpHBTDIKZbDQKL70aABjt
 kw1BhjQFG9o9MXUkKaRpvGjD+8gEgZsJDItBivb2UcMLse1Q+YqDBNPUVgMNRbvyBx/KnIEDzql
 uG0lwHsZHPsfknSpkaFFcGDyHMabXSmj2M+zCF8GUBqPQTFnmiH+xZk3+rQZtmrg6VsvmAKdSGj
 YDmh3dgDnQlN89LxaHgaptQbMYOZwNBGdL2boGjygK4MOTSXjWCGP6t1AjEoX0Q0x2X+l4hXujC
 unZUj5N5/1IN9XsK6N9prP+9wmD60PK/8QCPRGZlnwaMlE9qee4tChAcxw08yN8/BH9Cybpx+wN
 GPfA6BqvsLAlijTPSwg==
X-Proofpoint-GUID: k_YctKKyQ21bxuayvI3gK1i9sZN0a3NF
X-Proofpoint-ORIG-GUID: k_YctKKyQ21bxuayvI3gK1i9sZN0a3NF
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a102963 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GfE3bLbzyHi1VA9kviUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36796-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C45165B1B39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MHI controller interface exposes runtime_get and runtime_put callbacks
to abstract runtime PM handling from the MHI core. This indirection is
unnecessary since the MHI core can directly use the generic pm_runtime_*
APIs, and the existing implementations are either no-ops or trivial
wrappers around those same APIs.

Remove the runtime_get and runtime_put function pointers from struct
mhi_controller and update all users in the MHI host stack to call the
standard runtime PM helpers directly.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/accel/qaic/mhi_controller.c   | 11 -----------
 drivers/bus/mhi/host/pci_generic.c    | 24 +++---------------------
 drivers/net/wireless/ath/ath11k/mhi.c | 10 ----------
 drivers/net/wireless/ath/ath12k/mhi.c | 11 -----------
 include/linux/mhi.h                   |  4 ----
 5 files changed, 3 insertions(+), 57 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 4d787f77ce41..68cabfd2df2d 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -776,15 +776,6 @@ static void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 	writel_relaxed(val, addr);
 }
 
-static int mhi_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void mhi_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static void mhi_status_cb(struct mhi_controller *mhi_cntrl, enum mhi_callback reason)
 {
 	struct qaic_device *qdev = pci_get_drvdata(to_pci_dev(mhi_cntrl->cntrl_dev));
@@ -845,8 +836,6 @@ struct mhi_controller *qaic_mhi_register_controller(struct pci_dev *pci_dev, voi
 	mhi_cntrl->iova_start = 0;
 	mhi_cntrl->iova_stop = PHYS_ADDR_MAX - 1;
 	mhi_cntrl->status_cb = mhi_status_cb;
-	mhi_cntrl->runtime_get = mhi_runtime_get;
-	mhi_cntrl->runtime_put = mhi_runtime_put;
 	mhi_cntrl->read_reg = mhi_read_reg;
 	mhi_cntrl->write_reg = mhi_write_reg;
 	mhi_cntrl->regs = mhi_bar;
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 750da3dbb4c6..cbd2b442df83 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1220,23 +1220,6 @@ static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
 	return 0;
 }
 
-static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_get() MHI callback means:
-	 *    Do whatever is requested to leave M3.
-	 */
-	return pm_runtime_get(mhi_cntrl->cntrl_dev);
-}
-
-static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_put() MHI callback means:
-	 *    Device can be moved in M3 state.
-	 */
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
-}
-
 static void mhi_pci_recovery_work(struct work_struct *work)
 {
 	struct mhi_pci_device *mhi_pdev = container_of(work, struct mhi_pci_device,
@@ -1324,7 +1307,7 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	}
 
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
 	if (ret)
@@ -1338,7 +1321,8 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	mhi_soc_reset(mhi_cntrl);
 
 err_get_chdb:
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1385,8 +1369,6 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->read_reg = mhi_pci_read_reg;
 	mhi_cntrl->write_reg = mhi_pci_write_reg;
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
-	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
-	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 	mhi_cntrl->name = info->name;
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index f994233df2bb..db163a708064 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -226,14 +226,6 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-static int ath11k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
 
 static char *ath11k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
@@ -380,8 +372,6 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath11k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath11k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index ee87f00bc5de..9122837e5206 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -100,15 +100,6 @@ static int ath12k_mhi_get_msi(struct ath12k_pci *ab_pci)
 	return 0;
 }
 
-static int ath12k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath12k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static char *ath12k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
 	switch (reason) {
@@ -256,8 +247,6 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath12k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath12k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath12k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath12k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath12k_mhi_op_write_reg;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index fb3ba639f4f8..46ac60d01846 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -361,8 +361,6 @@ struct mhi_controller_config {
  * @wake_get: CB function to assert device wake (optional)
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
- * @runtime_get: CB function to controller runtime resume (required)
- * @runtime_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
@@ -441,8 +439,6 @@ struct mhi_controller {
 	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
-	int (*runtime_get)(struct mhi_controller *mhi_cntrl);
-	void (*runtime_put)(struct mhi_controller *mhi_cntrl);
 	int (*map_single)(struct mhi_controller *mhi_cntrl,
 			  struct mhi_buf_info *buf);
 	void (*unmap_single)(struct mhi_controller *mhi_cntrl,

-- 
2.34.1


