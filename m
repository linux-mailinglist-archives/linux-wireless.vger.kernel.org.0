Return-Path: <linux-wireless+bounces-35730-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNrLCynK82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35730-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA154A836B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33242300D0FF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3D3CD8C5;
	Thu, 30 Apr 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPcRaVaY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZetL2FP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731713C9437
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584652; cv=none; b=FWHoHZr09REijw6H3aipn6/TjBuKOGKnPsBsITnehicaICmTK1lkJEEifyGxGEDpHY9/2juehJTqMyPNi2EgvKCTzaRbxSIealPwmJ27iw6VlV7GUsxHr4018gNzUNT0JJB4GSIeNoHcsVzAig/R1R1ikRKqY4vM7kFrMMmEqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584652; c=relaxed/simple;
	bh=IlYRxTYpr8UDK1SO5u/zNsEgGC6NqQ2R+WDuyEbSVuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=loxerJFFAddf37PAptRDibG3NRRT7Z1iaCqGIrUptLviXb/OtDvDmcqRpl5H7TVFGeMYJVihPMqeLabMQCuvB+S6lbUGj3fLpS30cR7t6asJ68J5ycCx+mEeezEhLV8NsvaxtKE095LGXNmp63qVKVr6/y0cwf/pliAlrbWHbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPcRaVaY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZetL2FP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UHfCwI440678
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vj27SbZapOyUJvDwHwf/8ztbK6r7C+ocxgCkxyyRKWM=; b=aPcRaVaYm3RKHZm6
	jgVzkLemkCoeqIDDUMLbsTn0VhO0I466R+zbW6WAIdW7j/i6jYmgpsQ+HU5q5fiB
	8Av0M6LOPWutgVBzBIu3mpJ1xxL/ajFIF3Q2oJMDWtwe+SO8tmsB7VE/L+iyEDxY
	rG4jDc0yLae5nqRBTBU+/ErCmOJ7DQxP+Zpl2e0SFPqoVGZAGFTuP3iLzzlI5wP7
	a91gjwehP3IEIPplSGQLmKaOpNkkHoU5QQXXZydabLJ85s6aBh91F+U/qxFc+E7I
	hjB+gCqJN40TD/9E18+BB2IwT8ySemYnn2WDsdlKlrlxCHgug+XVioubnBgjBMjG
	keH7Mg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvbpw90ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2d93379001eso4902161eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584650; x=1778189450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj27SbZapOyUJvDwHwf/8ztbK6r7C+ocxgCkxyyRKWM=;
        b=QZetL2FPE24ONlZNx0qIXtzOGAXy3D2/IWscGogBxl8NkhaF1CPOPnCaC6rKLslG6/
         wnglJAqet3XWgvSWszuWQ5rRh4xQUQcYWsLOFW7ETt2MYiucbNVl0PWIl1R+8US1NWS1
         5Inv8fXoI7k/6OAboKuj/7ZErxfGTGy2KrRclmtsMZIh0KVZ6IS1EUqCP5r6/6feVAdk
         2R/NyunwmV4c0C/3cVc3ML+HJbYRjX2r3RxcMdiJNWYYzvOpvZp11NmWA8MzLdzFXPK0
         /KVs4brQXHCWfSM0TTjqI5wM8yzy8WCcaBYexrCxzGyOlYiH3vkuq0o3FvvL89kaCNcI
         gOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584650; x=1778189450;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vj27SbZapOyUJvDwHwf/8ztbK6r7C+ocxgCkxyyRKWM=;
        b=poqtfK9XaRgsVH5bmI70gTB2rPqDvkC4V3b73FLVADXYy3xQ9CS/C20J7Fe0VXzoVF
         wAPbmlS/Bn4+h+fe57x+ZV77MQYWKtNZY92noFptpHpuKpExD4XTXu8O/Hpux8Sl6WdW
         dumCLT+/qYzC31jvPJMSU+jOCfg05AWDUXOB0D04VovAIPDPBKX6KQPBIrwJjMhlzHUj
         MNZMylHpXjDvA7iTRjcJkIq7oqVdtKBsd/3W7R6cWM5j0NQbFwgZij4xfPMMiicVgY7S
         pRx270TF+FPawrTt1qMl0FRb3PMYEYFWrXNITi5/toM8FwCA9g7fuNRCS9Ufcxw6m7uj
         g2dg==
X-Gm-Message-State: AOJu0Yxnoqpe5mYNKylQlv7X5qvT5a7hLK0VL7JtnQyzYNMD0Enb47Nv
	I86ubU42CeHMHljAeQK5PooqzyzktRsC9svaPuCqeUff1Llj5URM9LHaByRcem6CE3+6Ygskw2k
	EMUs4yVj7IPHSUPhAbDdoexNCSzckWHxFOsA0ymMTDFDMeEwpqz/xiJv8XGyJgwHutU8TgmBahd
	FERA==
X-Gm-Gg: AeBDieuyWZNnpF7aBSBl2gY5aSzrXQichj3LTFVgehYEWn0eEWa0hYHnxavibDUqmr+
	i/18m0Q146WLTg1R3pmn7QraMc0ERI1K9fqNtE1betM+dVS7Q4qyC0U4iyLwuPOnd0MQKIGI02S
	pE8DD/tWI1FatE8uHlYzeFrFZUFGtCrkK/JuwDCzu30xVpWnhPQdTTuvqT093HQNF7JyAw0OZGe
	YALzmSVULvDCaUDVKCc1dXwac1rA7sm5vOiGyVFHJjFYYqQ3ts+NwFkupQMc2/ull7SxrK9dUhh
	pxvSsBHCTrsMq1oFrex3cm7DNsPTm+qUocL8rHpy6c8qNS0fs3o7SAXRNjtz1QhLns/odQxgLc8
	drJsV5xrCE+047hngxzg1B2tj+0xCi6UgiG1L7m9OkHO/lIcbxOZ8Qc7EEqezrtuTS2XlH7xJ1P
	zMRfJ6kAgz8CM=
X-Received: by 2002:a05:7301:2289:b0:2c5:b972:b436 with SMTP id 5a478bee46e88-2ed3f6705f0mr2288693eec.23.1777584649530;
        Thu, 30 Apr 2026 14:30:49 -0700 (PDT)
X-Received: by 2002:a05:7301:2289:b0:2c5:b972:b436 with SMTP id 5a478bee46e88-2ed3f6705f0mr2288672eec.23.1777584649005;
        Thu, 30 Apr 2026 14:30:49 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
References: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023
 type in Rx path
Message-Id: <177758464796.1848985.5158298683503256225.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dozrzVg4 c=1 sm=1 tr=0 ts=69f3ca0a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=C7aa6aAfKzMjnWR6zmkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXysGpCpBQyTQE
 duTj0X+xydnUOy4ZxLezTE3ak2XTLkp+tLFhWyP0/RusJpqNcUyNGkprCOv72iuUBf2LwdWKBjP
 ec9dNJIsgxnqJTPnNo/TF3g2WXlWD1U4b0Kw7nzfl3lQk+NWzdAZKCHcph3yoTsz/toASe1D8Mm
 5ALeeH2+l+/PGjMwh5NIxHkH1BcMZMpqe0LQRvNFtAMB0cxrc6uQYzVWJ7TJWpuNr/pitfOaTpN
 Edbs7P/JRPd5QG0Ma7AEU11tzC8lOxBEbc/Ewi02hzPo7eHrCbz+YD2L/R4PedLY15a6s18UAPj
 sMzE5rnY6ivN+zAtWvtkxlnAnzL6E7jNl5R0oHBY4M3xY52QEl8toyB1k50zpS/7E7dAjy4LI6H
 moAH7ZtDru0fbqzz3sgCt3J1RpSCuDeZmhYQsEd4JeLgkEGUAt0FCobOiGAQjx84ZdIZ1K7cB0J
 URVQvqp8R7+hMVIQdDw==
X-Proofpoint-ORIG-GUID: V6EQNZOxhkHd_QmUei-a2Fe4r8Olyixt
X-Proofpoint-GUID: V6EQNZOxhkHd_QmUei-a2Fe4r8Olyixt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: 0EA154A836B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35730-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Sat, 18 Apr 2026 22:06:20 +0530, Tamizh Chelvam Raja wrote:
> The driver does not currently set any rx_flag for frames received with
> decap type DP_RX_DECAP_TYPE_8023. When the hardware reports
> LLC-encapsulated packets whose length field is below 0x0600, the MSDU_END
> descriptor may indicate decap type DP_RX_DECAP_TYPE_8023.
> 
> These frames are effectively equivalent to Ethernet-II (DIX) packets,
> similar to those decoded as DP_RX_DECAP_TYPE_ETHERNET2_DIX. If the
> driver does not set RX_FLAG_8023 for these frames, mac80211 will
> misinterpret them as 802.11 frames. This causes valid frames such as
> Bridge Protocol Data Units (BPDUs) to be dropped. BPDUs are exchanged
> between switches to maintain and manage network topology, and must
> be treated as Ethernet frames.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type in Rx path
      commit: c4aa897fe234a7bbfc0ba246df34137e3a88beb8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


