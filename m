Return-Path: <linux-wireless+bounces-32361-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCRJEPgFpmlVJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32361-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 22:49:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A81E41C6
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC5BB30340B1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838363A2576;
	Mon,  2 Mar 2026 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j5tpmuxI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B6rE4bZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3BF39A069
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485662; cv=none; b=mKicjFbODxhjMXO0ldBu/g8yJvJhc5tBd9HtGJUKRAptn/YexZGsrue2yncOh2LVGQrmJ+eVlU0Cmbc45lTLMfCmDk7zrsqxcLEOnQ2wG5WXTsWngK1ld63J1x0MFMYRnfAO9zyd3o296sXXJDd18FaR1WvZrKtMSncbH8nVFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485662; c=relaxed/simple;
	bh=5YkNUc2Bpd9SlbNiw17YgTvxQvyXA5t7gdwBezm8eZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MmChOcIek/81pu0n6n30s51gmaxwpOINNaJKxPuHAeqAeKIdVG87xNCmOmT9SJDWYl0s95gYYll7M48A6y6XAwQyItaXPzBz95YMHg/H5lsfar0AUvAg+lT+kNe9sPYgun3o1fMJuRN2djxNh6MEoUXR7ziuN8nvmAO14KFaOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j5tpmuxI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B6rE4bZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622IxdZV2504593
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 21:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/mCon4jzur60YjChtELCL4HVeOYE7rhKXM0jGJ3T4w=; b=j5tpmuxIqKYV45ph
	tn1KDWEksrVsXouBge6tjcU1QLBaKnVLr/mUQ22mP+pEWEsNm+rFrkEZRK1HgB7a
	FilkmSBI+BjMG5a6Pyk1famhiR/5C5i99VhfQT94d4hVhAtuoaqYW0H9ab30NK4O
	f0rqwYWe03WebW2IDTKvE0dYK8BUvWXbuWKZiWR1FJqkYU2q0ZWigjoUaBVY0QPZ
	Bk1J5kc4LIp7omz0yK6nQucB81ZOGp3XZ8Tda7qLwcEBYim7y5Q2/Zd4jhJ5ND9K
	D62vkBmNCBnq4xDpuch8MDDSO0oGxkJ+AZTAXmuDs6cph9ygCi4Dps/wQB8w9kH+
	9Zw7qQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hety4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 21:07:40 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4beca8c53so56950639a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772485659; x=1773090459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/mCon4jzur60YjChtELCL4HVeOYE7rhKXM0jGJ3T4w=;
        b=B6rE4bZWxyCyxanOq/cVGkhcab4t9H1UUBOfUMdL7b0jO01RAzT5mGaFeSTEGmiJu9
         O0Kt8aDzQz0098YddUq8LIrfrEKOIDdlJkjaA0Akvbf8n7qye28A1kfy6usn72HOu15v
         a2fk5bH0EjO3RmtQvz9c8H4ddevfgTVfTen8SYpqgRM+tdnHjdNCYgLb29sNxFL4ig+6
         DYSH1MFCRn3LW7ELqeb4iA/rObRbDHv7rwn+VHMjFd8kKecQ+jk2PkKuOS3FR2e+JDQB
         jU1ZrIDesxWN3IXTgWA1+vNSUbazay0MA3AOGpOHjbhYKPbD1+RgChrZDx3OO3shZhhH
         moJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485659; x=1773090459;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/mCon4jzur60YjChtELCL4HVeOYE7rhKXM0jGJ3T4w=;
        b=wpN+grO6rK1MkDYy61qCMju0Jqc/IDL9rAj1Rnh34yrwemJxMKXbeU2GJuoKZxtAgy
         3anubgr42L8mAYmah5EJYv2RCE2OUaxZoQK7+2RP7MYx4TW2BlSKOg8FDh/7rSPuSzjC
         SsGVAyIVykyEYBz4bXJFxfiUZ/tq/O7LN2ZwgMO5F/2hBZvQMbjDANT6y/mFM924dKeJ
         ivq35RAr984vR5ye1J2fkBEgG0iPbFJRGSPwcThlrqAX0R1QLmUxBoeuSV/jaHPxVryc
         UgRCwZ+/yNol8LpIaUJfkwaIwsKkTGzHJyydUT1/RcOP9UHVtt8LwpwWeBesYdecbfoz
         10zw==
X-Gm-Message-State: AOJu0Ywv+HCqOWfytv7xj9dvv/EjyF+VJ22URUoqJnViq2Z3PpVbADWd
	jlLKeGwR5nHm6ePDHRx1fpzOD06i+5WSMZYrWnVQ7U+ECJavsp1HpIkj4HhbT6l/WnJz8Q8J6Sp
	l1+QSOfZeo4JABELYAN7vQ400DtqtHRDEJFoDuKRJHqp5qmllpZLPvqJFPMGXB+Cb78vkFURWYz
	QZxQ==
X-Gm-Gg: ATEYQzx4Nr5jHtWbCylaxs4XwnOdcsidsqJwKjVlhbCNDdQxgiS0LU8c4wh+tlbbOMS
	q68oDvTxDZShW2d8lFVUqOilRxGTxzKeMN5OQFUDIPLX0+2AvoVp6aBpFZJZD/CHJRCu+tgWlj1
	a1OLngAuBbGyTTOpiDFeqGrtq3UHFkuPE5r7O4XN3VV0UMZ/uKjdqH0atrcj4/DAeKaWDTrQM89
	DbkhprI4gK9oZjUdoP7I/Qzf+tyya59GbRI9K5D7fTS9e9sUFjeNSIY35pqVuaIj6CuhLBjNlu8
	EFRCRkaVdnmed++3A3ycFLFxWgspnkeD6hg8zzJVMjMW/a+gJn8kO6BRMHbZMQtv5CnVDd8+JDK
	eNgW6ltL3d/x1im3gSz9Rm16VopR+vmcZIh0X0RmV6Ow0shJXJSgWfJMT0YbKIhSmTNWM/HvWSV
	qV
X-Received: by 2002:a05:6830:12d7:b0:7d1:50c0:1a24 with SMTP id 46e09a7af769-7d591bc1a61mr5655380a34.21.1772485659560;
        Mon, 02 Mar 2026 13:07:39 -0800 (PST)
X-Received: by 2002:a05:6830:12d7:b0:7d1:50c0:1a24 with SMTP id 46e09a7af769-7d591bc1a61mr5655299a34.21.1772485654720;
        Mon, 02 Mar 2026 13:07:34 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm7449967a34.23.2026.03.02.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:07:33 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
In-Reply-To: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
References: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Set up MLO after SSR
Message-Id: <177248565349.1002715.8137030990862032793.b4-ty@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 13:07:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a5fc1c cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=hTPEv-E55Fei-ytjfJcA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: GZmFRajSZWdy7TU3xgvEP4GxWZiiZ1g2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfXzAR88oiWoDhH
 EIrVCDjQrWRO0VlSEGrMXLR6nKFXS+GF/42rxQ+pgfuoDA0r9Brw4ygHRkChOTJA4O6EkXHunQv
 4iq1Fe6Q1cXsxom3dTzp5d+yemFGXsiB3ZRcXIBnI2T7s9/edG1vSnCADV375Rr+P+4Wl2BmArA
 /4G0W4iUs7g7YFfv5lKIFptVsVtGmalf8iK2yTdBMPFgMt6WxI4R82mgxXFw7PiRWG7m6c4PYwy
 PzO13Ot7MqBg9iGk8fuHZLDaiHJKbIgFyQa7ugdRzb5616ms5+ogVsYmVlVpwcSolFjCeT4hGXZ
 KP7s4i8oAE8wplvtJaSi8GljR+NyimZoXNwZ9FczuabXZtf6lJglMUvDAfD986amRp7dbalWxi/
 NAecVeLkgAp2DpvXbp6mzXN/odt+7gYqujor949uvrOeHl3rlrdfn1wmYw5ezDf2M1z1HpUWLsg
 vfJBG8Zm3JHHJ/+YuFQ==
X-Proofpoint-ORIG-GUID: GZmFRajSZWdy7TU3xgvEP4GxWZiiZ1g2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020160
X-Rspamd-Queue-Id: D93A81E41C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32361-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 09:41:27 +0530, Roopni Devanathan wrote:
> During recovery of an MLO setup from a core reset,
> ATH12K_GROUP_FLAG_REGISTERED is set because ath12k_mac_unregister is not
> called during core reset. So, when an MLO setup is recovering from a core
> reset, ath12k_core_mlo_setup() is skipped. Hence, the firmware will not
> have information about partner links. This makes MLO association fail
> after recovery.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Set up MLO after SSR
      commit: f33a8e41826831fc8ceb5f62833488cd9388ed59

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


