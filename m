Return-Path: <linux-wireless+bounces-31461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN6DN069gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:05:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57064CDDB4
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C810D30802CD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A336E46B;
	Mon,  2 Feb 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwAg8PA9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AuS+0Zyg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38966372B52
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044116; cv=none; b=Rdi4VHkBPgfOnV5AQ52qRtyGbnBZg3C7eEnyhJdKVWKxX1PFBXvYoHZrEzEzuKfR5x2EQYRuuK0Qz6iS6dSMu2e/i2FnLHNVLxb8HoeWzPA/Is8wrnpPGynwKDm5Yjgc/jyJXy8U2oRKLDWRBbaR2dRrbTLrPw4C52776A8nHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044116; c=relaxed/simple;
	bh=RWqIz8eir+SgCkHIMUSuP6Rmaj8U+DEbiqVTK8AuJn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chXTUEuf4tFjsCOlk5g+WpIU4KetffUa/4NLmZzN6NGiDhFJbSvlfz/8904WqW8UfroV+OdppBw/MC3rxqjlXvA3NpbQ0epJHBt5/m82AcKjrumt5P016EroghhRishI9kzV7HVDoGrnFRq6JSfIeGYnbA5nuNNOwD1tHlQribU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwAg8PA9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AuS+0Zyg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CJSr72884359
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w2RtDWDxKN9HTbKmykyStBlq4A0fQOIpjVzLUAHdLRQ=; b=hwAg8PA94D8kPsZU
	hfpeiBVz/+CAEdftyhifT31Mnbp1POZoyZK0D+qYOfjlzJ4ljYh4godkGMA6uScY
	hDmqzTIeucARRZRZJGgMSDvKhwTb+U/vB9RQ2NjWDF1r+YKpOXOFWSxNLUU2s8V+
	i8tSUQBMhSlLEVnrKsCbVUlPoq7Ya5WvnF65WgTmdx7bvwuXcycTp31SmsFhdaXn
	2057vFwp3DIYUx4/fVA7F+7tQFMrO8iDdVAb8SJSHMnUbQ10Z1mT36of8kL9REb0
	t1olzyQ+zJpbaUFrUGwnQ1De9w1FNb80ua0GiasRuGck0SXfPjIWqfBwJaLt5Tz7
	j8pslQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2uu3gdn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:55:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b724ff60e6so5043101eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044113; x=1770648913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2RtDWDxKN9HTbKmykyStBlq4A0fQOIpjVzLUAHdLRQ=;
        b=AuS+0ZygBlD9lm9ZAMqr9xFt1Bu4+ltdW94oJP9w/IAgSHnOT6rgeEK6ESxvAmGTIK
         5jFuV8SxCx7364OI5qHb/PKrU2gRsjjJfw094qLnzaOUcpUwzlLVPYlcesurpcqIiuO9
         lvzIm/QXeAdcuRNEDixVHIfmlC4ln5+qpyzOWjfUVftfQw8564sdNCuyepqinQBmw8wS
         0hSFQimTecOpxmopDjntYpT1j1vhx8U7hZo6SDSKMP6MuOONeemEa4bBnAAlBnaZh5b4
         7YaBwEbbSstEH/0JS69pYAw2VaCTOx4/Ij6qOTm5R8Xi82OqukbE9beOgOxLR6nBSGsi
         Ob6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044113; x=1770648913;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2RtDWDxKN9HTbKmykyStBlq4A0fQOIpjVzLUAHdLRQ=;
        b=stL+/Y4OeKWoi90BKzjVMoOBTFgvCAEIrWJV+L4rG0DZ2Kfm7ELkohqUIh4hzznOdF
         bms2H0xDLKPUznVy+bUiL+B+wtYt/iDPNAv+0SESshHOKdGBpfEk703sPdR2OPdXv0vJ
         OIW+KKd+LxWwRTGLKpsfwNIYAWDxk4GiyXz7GlGlGNhUyjkSMldR9Uc9NQOZdnQkHK0y
         SuHrdU/uZgAL8E1RV1lEQWjGDOpmk1ZEZfJQ8t8x3B/TnEO0o+oM4/6EzAnnRLR7mm+k
         mPRAG5nkHlNpT5/s26/56kD1TMl5uR0K3kWKw6RVM1gJq/vYDySAMSxnjxeBoOgm7Tq5
         D0GA==
X-Gm-Message-State: AOJu0YxftW9aGKTDYL5BgiaMMsixnG0Lp5Bm2zFYeepUYdgld3uKRHHd
	HtxYyVUsFBBv1oxAk1+OgIcrZzJnZJdA6qiP/YMvi1GraauXrioPlTw3RkqlctUfMdCxi7VOs3v
	HoI4p006sgL3l6HsD59P14a4Q4b8FdrankqTfSYU4TqGGpteFiTa1P0/yIHt/BjxJQctN+w==
X-Gm-Gg: AZuq6aKtIf8+GzFob7JAjHZ6f1LJ29Tkfc6DlkH9y3NsgAPfXlwoisDFVgMknARIGUU
	zmeq7KwIIDgUNzcoB2/34RPUb0U+imMX7/Hk6ULPG5Tu4a0m6bhR7dY/Nbis9AkC9drIIZUlDpu
	mGuKHtSK1ZYacqXBi+Fvm456a8N6g6RTq4lETOHcvpA+Nez/UmSgcSfVca949J44D0BifDvuhPD
	E2sQ8qWCOvQEBqQ1DUfbbqkODdRL5SYOd9RA8Phk0mNTWTyzar7DX6VAds7oKTreg6+7fl/d6i5
	F8VCprM/351euz2OuTOA69ZEAZ7l42fEADxd8MOYgMpB4mbTqxLRTbQhiQml56HFaEI+T4k9N0Y
	RV27s9DiiTs7JM4hwjJ7+IEU9/3H06we/Gr41sbz/VWkA43AAjILA2kt4bOcX89Gq5h6VQg==
X-Received: by 2002:a05:693c:3004:b0:2ae:5b2e:9d45 with SMTP id 5a478bee46e88-2b7c8933b53mr3619367eec.38.1770044113473;
        Mon, 02 Feb 2026 06:55:13 -0800 (PST)
X-Received: by 2002:a05:693c:3004:b0:2ae:5b2e:9d45 with SMTP id 5a478bee46e88-2b7c8933b53mr3619362eec.38.1770044112873;
        Mon, 02 Feb 2026 06:55:12 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7bb9ca10csm14812695eec.30.2026.02.02.06.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:55:12 -0800 (PST)
Message-ID: <bed2e8bf-0a4d-4540-af9d-0c64a52c6787@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:55:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] wifi: nl80211/cfg80211: add ingress/egress distance
 thresholds for FTM
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-8-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-8-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MOYrm0dWg6TA2_HnoPW08qBsAfO4wbe9
X-Authority-Analysis: v=2.4 cv=OrRCCi/t c=1 sm=1 tr=0 ts=6980bad2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qGEKphwbWVISaAROvhYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: MOYrm0dWg6TA2_HnoPW08qBsAfO4wbe9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfXymr/iC5tppau
 5PF2/mXuw0oqtOApLuwQ8ve8IsKYfFGugG9MU2gKzv/8cLriP3hfD+35aC/Ey7VQ/tTa5qviIG6
 moWVxrITkFXnhUsCfGIIB0tAuhRN/HKYdFvnrE/igSwczBLUEjBfy/yffB7LbhVcZOTnki+6TrK
 8YuXx8+QmBgAupQoDNxNze0mVaNm9vQlgSyBLCe013+n60xHPeMKMoLu9TeVJpSWrYEBdeVYn9U
 hx18WzPwiyPJNDGrbO7IcAkuICAoR/mLlj0Gf1f70BWTHY6DNG+KiyR6jEdywrEcxGxLUVrTOjs
 kEDtU7Uti9nYSueDuG3MlaHA81gWN7cd2NPgmgcWYTP9rZZ4bNKh0VUybwZFmS81t3C3Un+eYby
 xArhBlYYszzF1f8PTFUE2j5S8Q0tuPYUojCIy+0ov5noRCTEHLbGzXK78g84Bk2cZtRy1oc7JJu
 jtdNJ4o1EONHUfc+Jdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31461-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57064CDDB4
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add support for configurable distance-based measurement reporting
> thresholds in FTM peer measurement requests. This enables proximity
> detection applications to receive measurement results only when
> devices move into (ingress) or out of (egress) specified distance
> ranges in millimeters.
> 
> The implementation adds NL80211_PMSR_FTM_REQ_ATTR_INGRESS and

use imperative tense

> NL80211_PMSR_FTM_REQ_ATTR_EGRESS attributes with corresponding
> u64 fields in cfg80211_pmsr_ftm_request_peer. When configured,
> measurement results are reported on burst index basis only when
> peer crosses these distance boundaries.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

