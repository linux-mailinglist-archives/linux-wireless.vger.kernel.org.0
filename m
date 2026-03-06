Return-Path: <linux-wireless+bounces-32659-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIObMONEq2nJbgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32659-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0EF227E3E
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78122301F584
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8B339875;
	Fri,  6 Mar 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIIkUsJ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGTPlVuL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258E23EA94
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831940; cv=none; b=jUuG6YApPFgx7Q5oujn+ngJmuTjqyRHsWqGkz07WxAOs6v1pZzajap20OD+gL52jtojp4UOdCw6q+NTCWPtLn3KZeJgNZYOqDN6VMpbWEn9J16yih3E+7jtl83QuLBGozncDE7jN8Jn1lNJu5fQZIVTN/zP9K3M1APkKEwqeLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831940; c=relaxed/simple;
	bh=t20jT0FDf9g9D0qSWNnT2VrZN+cvPHFzsriN1Y22IJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SDu/MTgqDHRqcatDl0QiP5KmQSxDMxkoyNCg9EUwbQOxp3+ONKAqoVbUCDkEs7pU4Yv7e56dAtDE9vpxQBTi/EncHNHcaeckVI65Bd0dptsMOzpXDUimy0qYvNy2ZaNAfwrSrrsJHwtdQEQW8ecWXwIbc91HwzpQAHLSZ8FBFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIIkUsJ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IGTPlVuL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWcKk692879
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 21:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjxfrEWFkAbT3xqEqxDAk4ddlywOSqsux0Qe3fMqtZg=; b=OIIkUsJ20OjR6JyU
	6YVwWuaY+FfzsR6fbB42zVZBSKFIg24fqRQJNGciKhwJso2yLZlH5IA7LYJ4NalA
	7rEul9EKPnTh4jEmaUS+dSyU0JJgWjqM9zuYtziutDdJSj1wNH/JyP67aL6ZRnAa
	7S0T7JDnPqZEleM+SkSSYt2n25CdDDlJVpPZrqhqDzutOdnF9XO4wPHt/ChyWaK7
	ppSxoC+hj296NVT66ns/WaJmcLWD5QKYu7fb7T095opPWi0F3G8xiazDmDs+eSAT
	F2TkIFb5NxaRG3z8WiwojuUGVw75RFjCFhKKm5kcoAJiACyDZoRdbnM5knaDU9Ze
	T2Fgjg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr5rd052q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 21:18:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2be21146933so7235715eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772831937; x=1773436737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjxfrEWFkAbT3xqEqxDAk4ddlywOSqsux0Qe3fMqtZg=;
        b=IGTPlVuLonsEV8YFEHOy/YbhaA4N8eky1B/ANETb5CaLHNeY9Euhunin2uHhqnEtVE
         64lvipMAD9iFZwWTwQ8gtro31blNpA29fLnODxZjVyK9YY06r2B7Prcf841M2Zee7+aw
         KF5W3Mv2mNEcvxVUc6yPIrTGSKzFdbP/mLXmsHkTcF1YKqPwUhu0MYNAaU9LyPFeExEb
         TcQTD4jpzotCtkds6qkIcetHLZCRkNY0ywQQ2VvHq9wkDe7X5ls/zv23Ex4T1fjvQbyH
         r2KN/ldMAzS0OFXyjgTD7m0zk+Tl6dMF79Ll84/fbDRGhs7sDmhhHKsmebrKSB1q7T9R
         GPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831937; x=1773436737;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjxfrEWFkAbT3xqEqxDAk4ddlywOSqsux0Qe3fMqtZg=;
        b=JerxtY315TDhtvIhhi5OSN20QKOcPp7z64WVttqA67hUtyhGccVj9h+wuuu/9Vz+uT
         zKziyFsOl0o+PlHwzwmhqLKOeeccoy8Xv7By5vGdm9PfQF0dgVzGE375oPmMGBbX31Mq
         N2vmkBrlLda5IB5NwQqmZ1wu79qA31R/so77nMJ3N0GiWvEJzRe7iCtF7W5oGZJ1Zjh+
         UdNuE2cLL6WW4KYFE5WteMnTD9OfG9jlcYklO110tSyXoa027yyP8QzulIXLgJGv6/No
         pY95iYa8zSS0//CcvfQbiEro5cMXVDrGtELUKSQEtdU2y6XYDRZedLGRlrcnrBtHBofy
         DzWg==
X-Gm-Message-State: AOJu0YwQibieyA0S6Z8B0DuufDJjGCSjFsY1qhglOGSoIEQNJx9qnHg9
	pbYU2Oic3IVEzfcHrUlFoTh6eidUbcixcJ6jbB7e3JyrE13v8k13bzFLroTGtC/CSETmVU00ebE
	CiZumt58SbBVO7hKFQf45ujbtzSNx6CpKg4a+mC7wjGdDnKrFaYg1RxS7ILK5Bd9U6zYIM5CACR
	2MMA==
X-Gm-Gg: ATEYQzxub4AWE4pA63a0TEUcxtPvkIJSj/p6YSiItrzQ1FE6LQCHbsiqPFTwtxHAp0V
	KgtaNVGk+Qm4pcYxTeG2ppXU4N9k4a4fj5DyTAb4rzBtemGjn/PpNTRZA51bi7/Tpj2PGHyy6aK
	+HtRd3hVG4POw0c4EPonQAFHGLk4dXv6oU+bSdk0AL1bKhRTY/NxYSbqywlBpHlHooc7xSoToSx
	9Xf3FkA6NLhBOXj3ttCMKWW/VYfYTmsC/jawqnsn3fWtUZFZR7+mOXULVL0AH53rWv/H/i1FsE3
	ZN0mfN1gTHlKPBCxmK8/3jU7DglR7uLEKhbzgAZdJ6rJpwyx6MFIzuxK+t/2W4uTwKhl2L0d10R
	ds+XA1P15uA6dRnMAmyly6gwcZtLfVKXBFAgb1/hmOQFsn2fETD2sF0ggJKhSYH7CAVpoyiXhW4
	tj
X-Received: by 2002:a05:7300:f18e:b0:2b7:95d5:3a32 with SMTP id 5a478bee46e88-2be4de931a4mr1383469eec.1.1772831936921;
        Fri, 06 Mar 2026 13:18:56 -0800 (PST)
X-Received: by 2002:a05:7300:f18e:b0:2b7:95d5:3a32 with SMTP id 5a478bee46e88-2be4de931a4mr1383455eec.1.1772831936355;
        Fri, 06 Mar 2026 13:18:56 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm2325124eec.17.2026.03.06.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:18:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
References: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix the assignment of logical
 link index
Message-Id: <177283193556.1373939.7970041781311586708.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:18:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: TMUS0TSCmmcZLLHJthoxluD5KDipxK6W
X-Proofpoint-ORIG-GUID: TMUS0TSCmmcZLLHJthoxluD5KDipxK6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfX1507GVqR3pHs
 wrrSKgrkZ9bgvfooWoRt/KKPGlct/TxdrxEL00PSjTQyBTiAp8H5F5CLl781CdjbM5Q+2MoMtpa
 H09gYax3eITlJLeEB022Q6RnRYGo+VHVjtQR0RsbzZwykbt3LM2VpcpeE69Dn1WfuN57edXCqJ0
 KwhJSeCCNUZEN2GNahp5CJZ0wXqUboiV67b0E06tF/IO3TiUIc0n6WSN5FXPPQakFNAFZYb6x3M
 ATaI7hh12YyFSsBMU2w+o6YOX8gvXsLVzf9MnSMXHtCJOq8jZo1jMUXBzp3g5YAx/y2QjfLiSwi
 BTmvoq8Gph6cZn+YoG22jR9cF4MtKQSGLX3P1X5Ch2/FZdAwX8hBf/e5KT1XxOruF2ptcoiLwlC
 hQsP952vZVjqf+/k7MbWL6fMVyMZYspZwnzBKBDfNJvq7VyKiRm10HjMA/0gyf+CredAqpAT++W
 heJn1d4fe8Gu5m8/9DA==
X-Authority-Analysis: v=2.4 cv=P6U3RyAu c=1 sm=1 tr=0 ts=69ab44c2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=N4T8r_4O-xmyLXOS7r0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199
X-Rspamd-Queue-Id: EC0EF227E3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32659-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.958];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 09:49:11 +0530, Roopni Devanathan wrote:
> Per-link logical index is assigned from the global counter,
> ahsta->num_peer. This logical index is sent to firmware during peer
> association. If there is a failure in creating a link station,
> ath12k_mac_free_unassign_link_sta() clears the link, but does not decrement
> the logical link index. This will result in a higher logical link index for
> the next link station created. Also, if there is a leak in logical link
> index as we assign the incremented num_peer, then the index can exceed the
> maximum valid value of 15.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix the assignment of logical link index
      commit: aecb569d7fb689e3e5b0005ca7bd0a2ef28915e8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


