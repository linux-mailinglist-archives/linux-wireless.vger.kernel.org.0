Return-Path: <linux-wireless+bounces-31463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCLPNDu+gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:09:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F080ECDEE3
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF50D301F68F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98423376489;
	Mon,  2 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+smIzHV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S/uOkn3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EB34D3AA
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044266; cv=none; b=lHHsDQ2LoJM8p6sqK7qE5mhvbxVNJfRCJZ8tk+Ofb06r1o0tJVxzzZYUFgH1V8nHoKR0ykGiKxRheRAfmTife1IMB8nXd1hnTsV4Qv/DMWnMTF0ID3BCH9WYWYlPzJlWW6JcdWBMZi/VWlxX2JQPHIyU/ThL7EF635Hdm/4z0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044266; c=relaxed/simple;
	bh=Ny4I3Tj0w94e6P5rPFDD7HslNKKmhJc7uoqxGcODf8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctzft4BU8yiZVHQCv5DmggtXkPLZw6kyOot/HjdWv6YNE/dZ9/dqsLbQkX2nH2peuJctAZd8neKF6ElIHhBNR5AIDRhXPwnht9ZdTfox5555SRaxJAk1lrb4g/Riu4YjPjBWkEAD5gv9EaPX/xnrieY9QuTvMvCVEkYBNrLAeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+smIzHV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S/uOkn3x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612E0b1A1657605
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XY1xhwacDJ5vLqy6VYoHS+V9m/bwxKJxSBIpHV+l9is=; b=Q+smIzHVCTU9v4e4
	D43wHGRAJQHjDgyJSP2aH6w6cFSb7bgpeufG+ErNhF142NqALJQO2BX468z0AfSF
	XMEhzW7SJi3f27wmhceMm67J/ir4wl7RFyJQzNOd6qIm8JObHLZ+Ky6OdgK/Nt3N
	IStCBHgizseTDr2udpLAHChlROIbMb8QU51bd6AdBAeM8ZCTouRh34GB+j3JSenM
	Kd6tc6GSi4QFHKqMHU61Sm8H82AV06+tEBIg/EW9jhUqZPuGnumNj7Ezp0DwY5uR
	7Snv/3E3gq6qz6B623djoVDZ4jbDc46ML3QWfu3f1+ESF8iH7K5JKD7K7EHLOEBe
	jjeFYw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1kgyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:57:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b7eddde359so1885377eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044264; x=1770649064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY1xhwacDJ5vLqy6VYoHS+V9m/bwxKJxSBIpHV+l9is=;
        b=S/uOkn3xnbPm+fMxzfzdNp6e9bXMoCnxJQZ6UzZ8+s0siMOK5/I6/4taDFpT7JwI4K
         CEczPAIAbLvBtousaToymDZCasyDoqR+TDEaxGnHiWKLTqpsaHPMUCCLrdMcfJ9p+KVm
         JL/jwuHLge0Zk9Ae5mDEOS4qdr606DRGA6MBYFZgx3wX72NgEFodblnBXhMLv7jFLbl6
         zQjUE/q9x2dZeUNDWznVv8gzKKbENtGztk2wnNcsnJMgnJXPEiIAcRFBfI2B9eEI3fEb
         +pCcsSd1AheFi5wiYVEGEcpHe/o5N9fYL2z2RPKwW+MNJDpFW76ID3/rpdEFpzmgc9ZD
         j44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044264; x=1770649064;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XY1xhwacDJ5vLqy6VYoHS+V9m/bwxKJxSBIpHV+l9is=;
        b=LqtFR2GTHVI+NYpEbfzM5A1uQsMUhWDHDICM2OVnbmcEN7GZb+KeQEzB51gEguAwUK
         eg44/bkQ422hU9Vl0jnUxgXDEqZEhZEE+EKd490P0cLAtOBcnk/1Wfk4mn6a5Y0//8yi
         df0GLUHLZZPWGiSwhZX5OVePLu23Xq0+3QH+ohMLxlSC9RmL6H6+v2imCwgho1IUypik
         GpY8QEAsKkaRrzTh5cc2cramcphZocMqk9nodSMsm8NY4AxM904vKLYIgCTis4+3e6OQ
         65VO8vx2UgguLJy+sBRmnmDwdgwyG22vkAFITJV789kT3jjnzXorJkNAcYITe90j1lXR
         tC8A==
X-Gm-Message-State: AOJu0YwbgTrBO7no5RKUzzycvu4Ac/nQ23DeL4opW1SSaWxzNRUQ7+qY
	jRJiM+sMH6h2bwlmDNwUCTNN+OTkwF0d6k7NSxvrn6ZA6dRP6hVF1t+uMqY+58a0cNf7ARVwGO1
	6EhE3S/6GxHQvLHGlENvgl18YZFSDp/VXQcqcsJNATrBPbuiEpTCgG/VgcO5CRFINelAfUM4APK
	vabw==
X-Gm-Gg: AZuq6aJ3TGf89JAv6pEMnlnm8KqPatIl+AH0lHJA+/ecwtrO4cab/ipkhpyoE1mHAX7
	SifnNongkmCfYSZeHbzTtuO5K+Mi6gW17xli8KQUJFUZ3NyW14h9gunRqC9rrtIjOgiK3q2fact
	SOstYvDgSE66bLMvncqT+SbTKEYLXqqo/p85nkM/uKoxqZlOrry1qAdBTubCGtf7XhBb087bOB5
	eK2/xDT9N/XR3nuMwmKEiF6L9FnlHWA+CSRaVr61rjKA5sI7WoH4k8Z1sRnqdMde/niSaJIqN/z
	auG9vC2dbuEFibcqrvt0c/66NjEjq5BtWg2BN2VeQ3WAn8GoN0GR/iFX92xsaa6lBE/9jdxKEXr
	98knaHHP9zvJAZtz52J/z1o/6gRs9hLVOVm/bpOmZhp4ArQJF5r1sU+HZRkFWlFcsENHxfA==
X-Received: by 2002:a05:7300:d50a:b0:2b7:26ab:1f74 with SMTP id 5a478bee46e88-2b7c862e546mr5037997eec.3.1770044263166;
        Mon, 02 Feb 2026 06:57:43 -0800 (PST)
X-Received: by 2002:a05:7300:d50a:b0:2b7:26ab:1f74 with SMTP id 5a478bee46e88-2b7c862e546mr5037978eec.3.1770044262286;
        Mon, 02 Feb 2026 06:57:42 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm20158472eec.3.2026.02.02.06.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:57:42 -0800 (PST)
Message-ID: <41096f52-3c9f-4e67-9610-0db2abd63e3e@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:57:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] wifi: nl80211/cfg80211: add FTM range report
 negotiation support
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-10-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-10-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Qy5hIbupcWEGi1n8jR1NZF75ytRcaApI
X-Proofpoint-ORIG-GUID: Qy5hIbupcWEGi1n8jR1NZF75ytRcaApI
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=6980bb68 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RKsdDpwRyiChBHnZDHYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExOCBTYWx0ZWRfX0G3KJWxDKj7r
 T1+1nznfVxhtJkc19tk0qVFPlUZ1dIMn4mGs98EudPYV9xwyUAZ5z1x8qdnB456XxkYvjyTzCsY
 pYCUM15LkqnF/c8uMwMY/T3oGQELEJSRcPvaqLsC5yE9PuT5RUdxmRPyRGdrBR8X8iQ+laHtyUS
 39df9iXfOvinWjLybV3KofVXzKXUikOdEwN50EA+BfGJCK76OU+ygrE7jHa7PST4b9JLVlzRmEV
 zotKROOGGUq4JTFbqPk153LfaLnIPnfymDNxh8KL2+bVPnXehELDg76W0i0hsvj5KIOxloF8ihl
 DICzlAPIxAmeyEaK+XMltoKy23Gdn92O/Mf42q1mIGWjiUCwyU0Sdgmd0IZ2ju6TJevG0os3iqN
 NEvpQeL0jD1VuXTpKrUOlWZlPJb+/SFvSyZyQA1ucMO+q0UNEYDish82yUL5XFjd57b71kNfjzN
 cbYnLz1rcnpAl2T6fCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31463-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F080ECDEE3
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add support for FTM range report negotiation in EDCA-based
> ranging operations. This allows devices to negotiate whether
> range measurement reports should be exchanged after the FTM
> session.

describe the problem first

> 
> The implementation adds a new capability flag and request

use imperative tense

> attribute for range report negotiation. Devices advertise
> range report support and userspace can request it for EDCA
> ranging sessions only.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

