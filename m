Return-Path: <linux-wireless+bounces-38482-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G2LhNvV9RWpbBAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38482-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 22:52:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D06F19E1
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 22:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aw9X705Q;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ScD5HsHB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38482-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38482-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31545310EC53
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074C397E64;
	Wed,  1 Jul 2026 20:47:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64733CEA9
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 20:47:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938839; cv=none; b=b/srxrmsawwquRrxrIGn2Vq3VqesmMFXwjfde2fGnPV7vBO0hTfow76jrGu8dnw8HCQ6Nlj2YoXAzGmi8IohOCDdY7aYjzOovHH7Lzqcp7qXH56EbkVPFSRt0pFwLsHmhE3qprOvWftNBAbujUMbgO8iRHOLGg0byXDzI1Piozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938839; c=relaxed/simple;
	bh=MdFcTJqT3Oi297lElfbEEF7NLj+JnAFX4C8wEhg0xQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYGMHUTXtyoXH1b51sAEIURZzoxfw+Uc6LK4820Fs5OQl/GVWuqGRoNsiZb6zhITjOqQwEzJMUYmVSlZhWqUAbVg1sGyv+x5CQ1w9jPuFtaDBb9yNURq+QWEMqHAYhsklw8bQ1ect7SaBfinUhqCCe/yAs61KuorbxkvaaDR4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aw9X705Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScD5HsHB; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmbn51691931
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 20:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=; b=aw9X705Qo1L6Ovd/
	eTeVF8FpPTtf3BQE+Q7lP+lp8yz/Yb9mqBTJtzUaJ5WAtjnunqIXASyncLXDhZAb
	uq8fll7/5pE58S3z0+eXMzIEEP3E4mIicZqYWQQIy1HyUW8nIjLmSnsIoDPcscb1
	k356hU2sz/qc7Li5RhKZVCuSPF15BPUColrEIkofStXUrG9wpaWnDpLv+Y3XWvsA
	tT9r4ACcG2yjTTuTNxNnh41IhYMkgDek0kyfLf/c6lAwi1/aC94cVGdNLWSf+JZG
	1nJlzp3fJC3vtDnFFkuystsmp4qlNQMOIOHz4BmSoNUTKNGZ2/cZHA7xZqnk8bb4
	Sz4ytw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0tkmgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 20:47:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c916d17dd43so1322920a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782938836; x=1783543636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=;
        b=ScD5HsHBV1iC2dEmcz5YO8LyyCVx2hJWdX+9jlWi/8KdV9BTt8642uEH5SEON8AcWE
         b5YQN/9ZhOoETKqHh20zPAfcU9NU3VSC0wr8kvQandj0kVtwlugpOnibKchFnm5fSD5B
         mlPLgxjpq34znKSPPdwXVk3e9m3skp/HJ8P4/DzCf3iNpReD+lfHBYOnfrOE+cUQzVTh
         b6BAy26PoNpuzUXRyC8Ji86yzYfdja21C3Fyc3j00X4OBV0x5MA30QBkgdc0hmyz6/60
         A1OPallgS7R97gnVBLkctNf/1DYmOjO6o1c7SsBlBB14jp0bhkeeT4AFktWOHsZav9Kb
         KD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938836; x=1783543636;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=;
        b=rkt21I1LDBkWyLIu+bW4q435t/Ip+V8xZ/odjkl1qjmkNseLEpRMQPB9eMiRpblm3k
         1dGKypzrodlUoV7GMXxndMSi2DtT7MK/1tlMs1dtbu1qxOXAHGZb9Jw52QPdKpJ1XK5a
         c/igvZhMOZZ3woArw/z+Tu3lgf/B/YL6yatfDjN+Xkts4306171wPk5SOnPmqT3DXyio
         P4anYDDfTDdFxMQuVUmRQSb9PAppXo4fkjOW40NlnDxIRlJ8NhDfMGsfr5/gdqroG5KA
         7F1TYZdnustl4Z1S/VSYjyKe7g8BxnRJ7S/4bLCw8aAcKx/fCSQk+rKHBfgmfQ1ExEyU
         G0Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8oBae+4Uh6r1D9Oem+0WHD/Fa6BxtJIu79dMxRb7ikFn9DCtJ5Fag8qQxNFL0lwHjBJ0FuA740xaQHN/xhVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG1J2Iwfuh2lZGnqx5H6KdLqRRgwawFC95ulkTh7si5AdK5SW
	6stHjpnDpkiHyS5iwcI7808+Jono9ka2vrkI/D0VWvadhe3F8TorxA/nFUugYvN//0/ziyht8xm
	XVa9OAxBFtqT95eSLoKZY12N1PwPM3lv9jlbOW7kVU96s+V9cBzeWyzm60oDWiHm78Y6U1A==
X-Gm-Gg: AfdE7ckkVQatkT0Rk1t/mZRKTFPXQiO0EwmB5f2GhUduzwD25jzdT2ELemtdcxRozMM
	TdJeKqL6tDeoQnecZfwIwwqjeRcL0/v9ehXKB36GmN0pLhVRbowDaO1oUQdgn8x/EmWm02Dc/5x
	bOOuvkE4NEh8tUwna+vQUtLPogKktBqACr46SCySB0aFj84N79+4hsmvnBOoSk03p+BXUvggrTp
	kEeR7UpZvwHiu+XBd0Onw8EeSX5BfSz2+c66GYgCZbINOcFqaZZkOabStpj8YKognNg4PV2aBGX
	g2zwkY7p0RTU6ANMzDQP39s0okRj5eiv2E5m358CP1KTXunt6vzA6g+ebuKT+i19uv7TkiU6gFf
	JWw6hfsvTf1Aqjc85eU3wUrYtfuIb5diDKbrfcSsZiFuddKM1kFzUJmL5R+PDMNx3T14K
X-Received: by 2002:a05:6a21:516:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3bfed1bb842mr3860114637.13.1782938836056;
        Wed, 01 Jul 2026 13:47:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:516:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3bfed1bb842mr3860091637.13.1782938835597;
        Wed, 01 Jul 2026 13:47:15 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc544sm1299199eec.25.2026.07.01.13.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 13:47:14 -0700 (PDT)
Message-ID: <152d4362-c45d-4d9d-af5b-d1c8d3d04e96@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath12k: avoid flushing scan work under the
 wiphy lock
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, jjohnson@kernel.org
Cc: kvalo@kernel.org, quic_kangyang@quicinc.com,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        stable@vger.kernel.org
References: <20260612032701.1619188-1-runyu.xiao@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260612032701.1619188-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oDnzVYQXi8j-6Vmw_XeN3LODU2XXVycT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX9gWmefDsZ9yh
 3VVpYjkW9zMofBRY4UmGds7Cs96pKrxxtK0w8Fp0hPw3NdTxvmm5nn1yh4bMTFHNWJ0hBEkGMFd
 cISvUbDSwkOQ0dPuRwSuAy/tQ83WZnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX77WPS2buHfVA
 4lekZrXl62oO6rq0flPFkkVWDZBOB1s23CDg+vsP98Z0qbLYVuYEuEuj1uTAmyvjVooTSLp7Pdf
 yYa2K5GygTPv8D84yn2fpMnh+pOxwVyp+PmuB1lcdAz7+0te/g51lnsCwc0kyFa/Nnu20FK+7fI
 /Bb+QXCrG4V7gyDyDFQEkWd8SIUZDdC3vpWHn7Tu1mOkEASsT/fFlDf6LSKzLW7Q9gEs/S6qkvV
 XJsqnmbOgfklu4/UHcN2KecrA85Q0rEk9yhqEA/vrkm1zlsfYrH+i/VFHTgIsOtliK8bv1L7gG0
 ijEwjqbovPYuZAPaqSr31HupDCwI1coYyGufSToU42Ko7NqywFe2T1PwJVsvG0yoGnF3gjW8dh8
 kQSVWmsAKuoWHQFzdRkHpVelsuk+DmOut+4ef/3CAhb4uMDYw59Wfn9simm3UhWbJjtgmcyQeNu
 i+1eACSkxGLG6hqNUTQ==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a457cd4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=gSjTWOtbipEii6uOW_0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: oDnzVYQXi8j-6Vmw_XeN3LODU2XXVycT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38482-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:jjohnson@kernel.org,m:kvalo@kernel.org,m:quic_kangyang@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 400D06F19E1

On 6/11/2026 8:27 PM, Runyu Xiao wrote:
> ath12k_mac_op_stop() is entered with the wiphy mutex already held.  It
> then takes ah->hw_mutex and ath12k_mac_stop() synchronously cancels the
> scan.timeout delayed work.  The timeout worker grabs the same wiphy lock
> before it aborts the scan, so stop can deadlock against the pending
> worker.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> The grounded PoC kept the ath12k_mac_op_stop() -> ath12k_mac_stop() ->
> cancel_delayed_work_sync(&ar->scan.timeout) path and the
> ath12k_scan_timeout_work() -> wiphy_lock() edge.  Lockdep reported:
> 
>   WARNING: possible circular locking dependency detected
>   ath12k_scan_timeout_work+0x25/0x42 [vuln_msv]
>   __cancel_work_timer
>   *** DEADLOCK ***
> 
> Drain scan.timeout before re-entering the stop path under the wiphy lock
> and leave the rest of ath12k_mac_stop() unchanged.
> 
> Fixes: 2830bc9e784f ("wifi: ath12k: implement remain on channel for P2P mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

This patch does not apply against the current ath.git tree, please rebase.
tag ath-current instead of wireless when you post v2

/jeff

