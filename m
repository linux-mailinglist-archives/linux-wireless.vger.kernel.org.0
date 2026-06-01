Return-Path: <linux-wireless+bounces-37271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A4UNTG7HWoidQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:02:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A5622F80
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A744730571F5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2A3DC4C8;
	Mon,  1 Jun 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWtWvl1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MzNaRSGN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812083DBD55
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333233; cv=none; b=IJR/a2MwWdH+fcHFDUqJP8LoAjCKqN8+NrMFjRR/kkWoy815YNJzvleaov34+m48Tsg/aCRlqWilgyVtqUtj5OCnIzz0oIRkH1UyplobGpjYIw+xSRYg1/MqnoRB05KvQzSUytXQ4l8b4yV5VqU7hpcqIoOIdyOuLVm9Dy0YXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333233; c=relaxed/simple;
	bh=41hV9/7reJ1X8Pb3wZPvRUxxQko/AJ+wb1pLTfUpW3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3UoC3m1Sa0mPAl/svRcHGi102+KFTOvGkhfNbPugU+9iwuFr+MqTC6aKTai9LPZPEDvG9JUrR3ZvNcJyV4P+G9543XAZeen6qi35DX73R9WUUTBCFBCOiqV4q8L+5uLzaul7KkvM8/BqkkvblV9LaGtfdMHG2kuesXpDPsjM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWtWvl1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MzNaRSGN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FBmWu1258152
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w6LmX3hptZ7zNGS/gjK8s/rM2al2ZqDKDWoSUmU/Yp8=; b=AWtWvl1usKP0x4wS
	utWaKnaO1RnyBVYvxu4c7z/r4BRXoQbgmGKGeYtXnWpxg5hR9p0uvqqOPQWx5UXS
	a/oMkEkEjdFC4PnP00rI96MTWNKrRU+F7N+ugV1A/o5ZbxqCz97kPhqbwZgfmMJt
	3I5hAl3wrh1E7TYAR2+vCPPSr/DEL68Oo2ewH/popD14OcASzZ8doSoluJMqT/Wg
	cpU2a2aMVyVzOC/ZlFSTkRn4SRsxfca/SvqDZlc4ZS9CLVbVsGHhmX8WXJWuPQEc
	EW+b5SxUPB94ICySr+bKPjpwU2gXDID9AV3YS4wwerMSTo46KntEcBnS7jUzDiKA
	k+DF8Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sst2vc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:31 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137ea73393cso2212361c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333231; x=1780938031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6LmX3hptZ7zNGS/gjK8s/rM2al2ZqDKDWoSUmU/Yp8=;
        b=MzNaRSGNJKC1EQt4Kda/NkjME7Zl3uhV3df/ma9DgWlzki/aycD8g0lnaIxO7hgyKR
         fJ4+o77UiBuwFEIRW3BMZBYf3QX0X63RRvhMIUwh1JZiIAE5sSrwJkpOUMnOo08JKL0T
         09ckFc5Ze84XqoNN21rxDHLqQjw+bfxOHZVMFNn0+OjesWX/FD3b6RJTEkMNrXHwGHgW
         +51MpfO2G+hlafG0eihRqEHyEb4yFfdBTgZ7l6ih4o8OOoY4NOFQuCwFkr0mfn41ET+e
         Cnkz+rnVg1nzr10H9QvxQvkzPeYjrMURoyXwcT0e5ZI69s7XMqZablRUqCh2tnmfPk1B
         qNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333231; x=1780938031;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6LmX3hptZ7zNGS/gjK8s/rM2al2ZqDKDWoSUmU/Yp8=;
        b=Wr/gJtw0KcIqxtK5zITmk1fXxyOTH4e/+UWLdmgWOMHf+7NcLh3iN/is++r846OIlU
         jL/9Os+BaKYW/JBH0daFIplZTRE4GN9kTaR6VSyeQ9FrpFHVUYauxQ+8u8o2hm2IGNY6
         zmECUFiTsAY+16n0XlsBbnIIQ2OU5PvFyNJWCx7zbMaWQv6/ERoAcDxgsy/HOUr7bxMV
         MyzvLfjBefnoI95/I7WeTq3hditW3pj2IU76nDomG7zfBtn/IaS7zLPRr6lkBk9+GC5r
         Dhl9rZAWxyiWYUHrNjGlRQB4Swiwvp+QXt58GSIW25HlrcG1I9Unqjpq2gpgsm2/GVuY
         DX0A==
X-Forwarded-Encrypted: i=1; AFNElJ8M6vo6HmJPQzyrNpx7EfMfldUQfxtfUwwWo0jVVr0REqMSenSO8OQw92ygsnepT1C16B3tiJfvKmWjP3W+NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pCRM5U8sxqBD7bSc0vy/+U2mVnNT+A/0DcCWEWdsHrZpeGuD
	bhrOyLX1juzcTzGq/AxA0MuvEFQg+25iP3Dy4WojJ8NnWcK0YLb+hOPRPxKLtSXZ3pvM4WMxvWn
	9wEmfdj9jDQ+eF9AUgeHbk+kAaup4JmkbXIpQS1OnPtlWKcNcyrZ1Lcq1svxP/4jMG83jgpxrgY
	BMWg==
X-Gm-Gg: Acq92OEIJRrk2yXwgXVwX77N8tM74L3AlDkrQyXTiO7HvukFw0X7VYR8Pa7roj1Mfju
	e8iV+v4nT0yaW2RCzZZtogZpGta6XkJRJ0kjTU6K+frcDOcgF7CwY14J5NWqUaZLQxli57Sb2Ty
	2jaYOtNoXJjgdbz4rJ/GhMuA2zQ8HhbZWLWu0iGWx46Ij58HB4aP7sC/LNAGWkDnI4JAy8/6SEE
	DkORNl4Fl5T2Z5cOlz2Y96P/GDL9yHoW/PqtABSW6TsBl1/uqvKqbNrZmiSZ92MPEdas+FiFHCM
	pIwvSEu50xWaqwPvJivCdmLscQdmXWhKYKmWUfbmNJLBLjqlo5OoHwUNyc1ScppsoBjhmZMqJo6
	87ObeoYInbUrreR/R+IVvSoZKOTZ/dMp+xhfmIPN/x9oBAJWcGdlITVWczhY8R6eUp1fbu5k7Rh
	FMc/DzZ70Q8Y8=
X-Received: by 2002:a05:7022:6ba6:b0:136:ac69:b0e8 with SMTP id a92af1059eb24-137d4143502mr5204498c88.15.1780333230917;
        Mon, 01 Jun 2026 10:00:30 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba6:b0:136:ac69:b0e8 with SMTP id a92af1059eb24-137d4143502mr5204470c88.15.1780333230164;
        Mon, 01 Jun 2026 10:00:30 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: dp rx sanity checks for
 invalid length in error paths
Message-Id: <178033322952.2045173.3876404183011075387.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: jkBrTv8RpGmUFKDqlA9PB8Wp9ESzqrYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX5jY1Di1Awk38
 Y1rlyu8AqiJsg0GaVN825CxupdWIrm19GwjtIB+17BhiLU5LVyWC6yhLIujJdkZWjY8qMF8tXul
 vzCTa3iwz2pgs5b6xzm+xmtzs8dpo6LOeasObTWn7c5lywOrN+47FMZ5Num3kMHILxkE1JRmnJj
 X3vktwVJBFnlMy2Z61VQwTQhQhgby+eIz64MKhAAeGHJjMm4ggHZNp64iOEyaU5gN38HXF7k9Dj
 DcJimyRnIzvMsnrTIR6UsM9yb8wzXqpxbIDioETH8rtpJxmzq796mR35nA/TgP+CJuYFoLmTgLk
 cQlI8yA82Q834kxIhpL/p37PSdEY8h0wSGF4xedESiyaOJ7QGmXQZyKjba1wUkY9AxQnhND23fe
 DJYQID/UfoKGICknntmOUl4EkYI969f7mLEyQtSEvA0nXOuI0Ez+IZruIO2nzw/piOViPaACnPE
 0OyB47VpnoDY8i0rcfg==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1dbaaf cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Dupxt9FihdqWuyYA_w4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: jkBrTv8RpGmUFKDqlA9PB8Wp9ESzqrYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37271-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 509A5622F80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 12 May 2026 10:23:49 +0800, Miaoqing Pan wrote:
> This patch series adds two defensive sanity checks in ath11k DP RX
> handling to prevent invalid memory access when hardware/descriptor
> contents are unexpected, especially in WBM error scenarios.
> 
> 

Applied, thanks!

[1/2] wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
      commit: 6b471e9aefee9ed73278eb1141e0d8530a56fae9
[2/2] wifi: ath11k: add MSDU length validation for TKIP MIC error
      commit: 4d8af936b4fe377f3d7700540f301d8e45e8759b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


