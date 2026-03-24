Return-Path: <linux-wireless+bounces-33775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPZCFfyWwmkbfQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:51:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81C309BEE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5C3630A234D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072834D3B9;
	Tue, 24 Mar 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDUE34Df";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fRLsrFEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD3261B71
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359992; cv=none; b=OA6rOhi74i41fJ/35IDH1fsYjMvRYwhEj3uKsjmDqzs7ZqQroTsVyl+6zBvSsqAv7o2V/YEudvWb5EbpPhW6jnVXxsrmfKCyTu4Zth16guQy5U2JushwmkMbSfJzVjDqwwW7vw/DN4prHIaGP56c65UYtq7vH7eoqYONmhSt+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359992; c=relaxed/simple;
	bh=uHrkodEXj10xamcYGNRvk/i+0zzDQ08b/iDJmpoCKLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=as63hAQ4J/wTpBA6o54wduTWMUfNe05PVyPBcBOgW5cXBtSqW51GLCT7QkV0nVgQLmWrl9NmRpVDiZnle8RMfSw8B09M59hcrCLPWQk/FB6TR4MEQ+w/IjhJOS71PKQxYh//QVX6kNn2nl6Vu4QS0VcLkAjYTwyGBchdcNYLG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDUE34Df; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fRLsrFEb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9PRi33934924
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cjGRWjPnaGlclXk0EfY1F1ko2cvnaYk4eZjxovYkm0=; b=dDUE34DfOvsrhZ6P
	V/C2HVTyAh9sGV68IPzecHZp/Bpg8h4zIncQOAmQI3gJUVT3hgVEHaXMLFh42eN2
	1oLKv9cnSDCu8kywp6KQD8yB6Hvmul7tIY9tx1xsfMsUKmFGpivwt442sU6ctPX8
	usQCWwCfivx9FHbCGciCbHsFHGzu/GXnUcgDlxDhsa2JrXE6tFXscybcJ52pCGOE
	uQRwJJHs8IP3m1fGk28Sot7bvB8n4DFTEEjArtYkzfk5rRCKr2nY0S0pzCqQ+2TL
	UA/ccSrmHAuBieVJtI4Xbt1oGvMWY7gQtEe4EwpxuiCoeh+Ka5tRdVjqzj+WqBSt
	yf1LjQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0mpb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12711ec96fbso26999199c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774359990; x=1774964790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cjGRWjPnaGlclXk0EfY1F1ko2cvnaYk4eZjxovYkm0=;
        b=fRLsrFEbJq9kxkM4c5M4PtRhWeCAuTQdylbdrxEeotHTGzkYBR2EWYULfn7+07q9BC
         tZF8aHeOFQVRUOsw3pzWxIN9ahRzmqdo3m5c/KherLq7Yx0aDZm25yJYCXgZ1EJFoJPa
         oLM/rivUssqq7U2Np58mWIdhlLzpvAs+Cs5fOLN3BghEuE7zOKFquRHb8cNHrRmKZ/mj
         58LsVQWuDgvPuVfewzr1DT6GA3vrCDGjoft+3AwCcqw+whY6Dgx6zG6xcXG7Isw5YEWb
         djQsOZtqfP1BszU8v4r2Z/eNyqM9LDUY5MmOdROLrbjpf4sNhzPcY8pDCPny56afus5R
         Mp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359990; x=1774964790;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cjGRWjPnaGlclXk0EfY1F1ko2cvnaYk4eZjxovYkm0=;
        b=lbetqh17uw4Y7iL9+BuFtNiR8/pcRI663R3ZYTopACt9dEpULuZU9fvWiHlMSFhrbF
         4fgbqUrr2hkgsCHMYvXaDDzygsgQKeDXfilTMf/g84IdVwdQjkoo2hasCOToYlCw5LIW
         /f8a9dNlURXlTdG86X/B9+Ie0XfhgIi3hj7P9Pg+5QQ6AZJu8GPuUK33nlgMKEjNzfwW
         RXCpozQQ+U68xUON2QhocyuVY6BdO16jgWOvz3F3sWPESFPYUPvhwS1884I3eZik/U06
         8xTEhFnZHIcJMmJaYeet5GWYcp0vqMLJjOSS4uodzOtLmws2TUMwRu30DRHAdNNn5SyG
         YJZA==
X-Gm-Message-State: AOJu0YymQJTVXBlRFh93ei6+ulgr7ZKioznuy7A2jKygU5xtHAPlAQ2w
	wBu6DHhl3oDT+k1wok3NIIzxPGOcFacALZVJ6v+WmGC/jXfyueaojZJn0401S76AmAcM9JO1X7f
	P8fLUegYq/qYN4IA649Qe7gX5Ex7RjAaDMwQHP79mc25+RJVH4WXwPn/D1mel0sMnPxwDzw==
X-Gm-Gg: ATEYQzxEGtH6Gp9ihsgYSyl/T1Nbxme3AWG36MdBFcv8g46qPUxJc07RD0XCeTecwk1
	PupBVpMcxTzkWo0EgrFvNIBPkwFmYpPIwRjxObgAGTxVKhajObhaOuVQ1DI7Oma5zdH9dNFRdAF
	P2Sub6mtULs35U3xmYxdGWSen85poUkzChvtRxk941cV+VEzVR1AdAdfhX93FZ/HcZ9cf4e+gIm
	e5HSKDVLq2OC22BPBOTkkh+WDvv6H41v01hHB0CWgMxPAr2c+1HzDTMnvg2DH2i6jLBKxdq8kkh
	hdqRkFGPNd0ckWWZ2VU21ypYj9C5VeTRq4Qau54sBXwFyLrsNGYlzFj1UDvlSlU0I7xIUXFma08
	0Igkh+L/d4a2gcA6xLPI8HzGIvP7Za5f/O9gyfVt2x+1w5KMOg3M5hT+vXCTqxrKlnu64xFLhFB
	Js
X-Received: by 2002:a05:7022:384:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12a7265d4b8mr9036295c88.16.1774359990289;
        Tue, 24 Mar 2026 06:46:30 -0700 (PDT)
X-Received: by 2002:a05:7022:384:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12a7265d4b8mr9036261c88.16.1774359989675;
        Tue, 24 Mar 2026 06:46:29 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733e794esm11368447c88.6.2026.03.24.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:46:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
References: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Pass the correct value of
 each TID during a stop AMPDU session
Message-Id: <177435998906.2954589.15845096878767678898.b4-ty@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 06:46:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c295b7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bfulyJ3BcDXNzwfwHewA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwOSBTYWx0ZWRfX76uRvacooZne
 FBcq2Ih3mHa1JTXHw19j/xQeHpdy+zRXY1DzJI8Y9XHo9y/4Y0q1a9NA/xK9Jmqz7+JCVwa/3k8
 EYy1waOO6fj8sQLYfw7NEsbbRoMc6cQ5Rnruryyli7NSfeV5h8Pxe3E2cJA9FbYz/aFvo3BIAkA
 l9RC4KA8zf50wHGZyGechhg/dV4ecpTNp0MYHx12GsGw+03DOTuZrkWaugylxdHMUO2JunYyO86
 Whi+o7/iXild+JMSSDI+R125WD5JE95T/rsE9E9ORUjog+UwoZKmNCq8ljwokKGpwYLOulfUmb8
 1T/yDIBBdNxfvIGSDQYni3jaCbZrBqZ3rtwb6pARniFYu33LfP/js01mdls53NHo5aVIp3+SImV
 jXyAYUVI6MW/DESDiRK5cmw8/Tu6bsbAbzRSnPAQuNWa7RUbhOYhItvx2JlPvAURmuxEsSecaWD
 EtpdZGiNE4Tj8Nj2Svw==
X-Proofpoint-GUID: r7RnxXC61IEIrKhjWjmg6p6xvSnRK4Xj
X-Proofpoint-ORIG-GUID: r7RnxXC61IEIrKhjWjmg6p6xvSnRK4Xj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240109
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33775-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE81C309BEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 27 Feb 2026 16:31:23 +0530, Reshma Immaculate Rajkumar wrote:
> With traffic ongoing for data TID [TID 0], an DELBA request to
> stop AMPDU for the BA session was received on management TID [TID 4].
> The corresponding TID number was incorrectly passed to stop the BA session,
> resulting in the BA session for data TIDs being stopped and the BA size
> being reduced to 1, causing an overall dip in TCP throughput.
> 
> Fix this issue by passing the correct argument from
> ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
> during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
> which is the base address of the array, corresponding to TID 0, pass
> the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
> different TID numbers are accounted for.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session
      commit: 4242625f272974dd1947f73b10d884eab3b277cd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


