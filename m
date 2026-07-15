Return-Path: <linux-wireless+bounces-39125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EHnDCtAQV2o9EwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:47:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A375A835
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:47:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=n5ZCNZje;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EHti3kjv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39125-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39125-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D287301FB25
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0C355803;
	Wed, 15 Jul 2026 04:47:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F432459D1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 04:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090828; cv=none; b=PRRdxm8KoBifRzOHKjy/xBq9g5KrutwFfg/jI2mAw9YfYzG6OkzSuBYNtb+XxP5QEXPmHsBuO4XGjb/a5QrY2qX3wdwl47r/AfjXWPerutkSBKuGKMkgn/MVEiAnHszcwIPW2Sa2XizgUvlmPFB5bhMKzAhIGgV2Ky3oQp0K2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090828; c=relaxed/simple;
	bh=r6ZuurDGK6UwF5g8/AftJ7m633AyRIHmPTqn4G6VrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HCO7MCn1IuWqxUrmUjZbqhQ+ma+JGb1ZYCXeSD9VXJPblfbKlIMeGAjCfBWgdbBalaoFLLuMOtZn6eX7cS5eBBZTM69mrlxBxHkwdd5LuNr4n3f771DPX36klftKeVdbdvefCUiqqdZuROiYAi2TKCcV7c3KGXvyNNSmJ/PzLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5ZCNZje; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EHti3kjv; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l9Im2269664
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 04:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jHLyLy9xJ9opQ7XzFo2f42ngzaMXGxPCwphpvbA63nc=; b=n5ZCNZjel4lcXrk4
	1F/5Rx2sk7fLwooYlb4VBOJyPAigQi6sErTPzf/h9xZMPXAcrM+MeGE7nVNml+SM
	jsb26nvcGgu0dMKNdySuAWUnzAKk4bauivC7N6+OQKQPn5iOFneYICPoWAqmUht5
	G/H4AX3PtcGPpVlBNls/1s7xyJNPmf5vwVHteDDgqkjRbao/at7vk0T776fylM1X
	88+yBGES/EPEMf4RfZflIbA5QsyzFjkY/c4rZWQgDSpNAhqbcrOuqoH3nY2v5Lj6
	YdS+VYQ5gOCCAMjAk4ZL/mUtzFG1c63CCC3Fkyjx/doXotMSq4VkHO2VN7uzpAs3
	IAy4YQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mhx3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 04:47:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso19501481cf.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784090825; x=1784695625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHLyLy9xJ9opQ7XzFo2f42ngzaMXGxPCwphpvbA63nc=;
        b=EHti3kjv6iG6TA6LMNGPUWv4MpIGnPeiQnoedHh6dsyLIlfumGwl7pcQb/8AZPock5
         qewWHZUsv6QUNyS7oJG4C8pKjEaAE5zONHMq9F772eMu3svsLmEXqtyiXrcjRfbc10WW
         u9u2sjSG0ua0YH9HKtSGgrKd5SbMq4rgdl8psJRSNprkTMdBEkZDP5swxRGnB/XSr6Gs
         Uno45q1uP4+8xSnXcLR2SAdl5qZKbwcovoQ7Un6OFZyRRC1x3lQ854dh/LEwFpBwqVXf
         bFjiW13GA+pkcfWMeY49HLmTG104g6JzixGWCzvebpl5jVinzhBzZxTExZHYYr5L9hx2
         RgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784090825; x=1784695625;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jHLyLy9xJ9opQ7XzFo2f42ngzaMXGxPCwphpvbA63nc=;
        b=X2axi42vOcBcR96N1RdHq9LCPFAn3RnjqXI0J+YGQL4SQjk48HmMvCX4mSyYxvKXyz
         MIZVUPhYyp7w7v5sPZcLfAXPu7y7xhVO3ODyqo8LN1KQGVQZ2QVbPwMHEmboCIWrLjDy
         5jdbbwLQqQxIAcOoQeHbWGahyAXbRVj3db2N3/elaOo8vB9qfzQcjw2tVwGFBJ1XfiLG
         dAGDQ4pvlnw14goyFKEK2XENUIEVv9GCFD41hN+ChCR/JIcMuZRLj1R4GNhxxdm5BPMX
         Zb3/Dgog4aNNLvZRNglk6be9kxf2Eeq5dw8CpP9XHdb26yYVGiXGoUovTidcvUrzTS/Y
         XoIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqZ+CKgUPvODOgXLpYHGqHB7fSPK5s73LGzJ+rb35CGlYRNCyQ7xSgTDHQq+8xWU9e/7h6S9s3WF4R1EtiGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qYUdavMYTZlC5UjR2cWfF1zesbHSfg33/JzbeHrprQ6qBF4o
	F+T9Io2Kbi8/q4S++6C1vtEXx7QPmsv7+0Tbkgp+TFWeEjSQ/XSho5dWyFCB0U6oQBC2PkQqHzU
	90LBQX5pvFtVoCNwDoFD+l/6TriAfDuW2YDkOuCN24RHtjWg7NwZ7F/rfZVqSlgharcclnKUfzN
	CJpg==
X-Gm-Gg: AfdE7ckkFdl1VIf6otXgDLPevrkpelym38g3d7CNdyyivCNKSmBCIoTQcqIGtu9h3LO
	kSIwUFMf9SjubKH5MhMohudPrkl0ll3agsloYkI30WspVVmpilSNEELOAdIIJHGtKAHZYObQ2kk
	OgK979OXGZ2JMIxYlaUzfFbPyDJPwUc51qBIZ6rfEdJKXX9HyshPjd3qeZQQk/ty0szhY7O0XEM
	Bo5+32ckuni8oszBXrV8wZv4j/4Bs65I3uZAW/j1tEOAvc4iMqPXWSstEZ+eTsuE/k4W+hT55R7
	HyxRT3gNtfB3aRR7zBFUEZSHxVZbjzb/F098boR6XSCWSRfxRXNgDsnKTRMcSTEbSx/DjKAZUyJ
	7O8dzgHdGVHIAVMoCsgQe2at+OChgkS9YBeb2/XZ7
X-Received: by 2002:a05:622a:346:b0:51c:857f:9bfd with SMTP id d75a77b69052e-51cbf21096amr147710721cf.41.1784090825340;
        Tue, 14 Jul 2026 21:47:05 -0700 (PDT)
X-Received: by 2002:a05:622a:346:b0:51c:857f:9bfd with SMTP id d75a77b69052e-51cbf21096amr147710621cf.41.1784090824912;
        Tue, 14 Jul 2026 21:47:04 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322dc6sm129267505e9.10.2026.07.14.21.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 21:47:04 -0700 (PDT)
Message-ID: <5cb62eb8-f8e7-4425-9e2c-2ae400bee031@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 06:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Drop redundant NULL check on devm_clk_get()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
 <75ef4371-b66a-486a-8555-e3a3f6ee5d88@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <75ef4371-b66a-486a-8555-e3a3f6ee5d88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA0MSBTYWx0ZWRfX+WV6SV4ZNYgN
 FdF0L3mNOJEvLDr8BYze7/CHudW4EhWJQqbR+GSjhiBeLbiA3KrWyQyhxsRRFHwJ+l+4i3coQC7
 IPt9TQ6vvwxSF9BGjAcJqcUV5KzIckAq8atEItRbve7cdRIBXZHB/0oQ8TsmC28imczeU93jhdb
 s+XIFDm3tbpOx1vOBvOQsyfzkGVWdh3R4X8vws7FFx6zgVqQFcmc+nWWzIgfNdUhmup31IFXOk4
 bkSEqTWt8+NlTBkt6uAo0517eYd97DMhAadwPoRb1+IYkzU7qJv4n3aDb9qYSq+Q3QvOAq/mIi9
 hYmHerj6QTWjFNPftYbph6Hz6Y4fIg5l/fMjpS1jscbBLzy+ko3yu3wmGoaMJ3a4RyDnusi9QHj
 CYGbrfsdjFUCqODhOk1oBy3dxMBr/KQ2KZoJB1lVcHWPHScWI9d0BajN9MmDaAXfG0RB2OaItlg
 n6IlgMzw56c1f2UJb8A==
X-Proofpoint-ORIG-GUID: mYU0gzOAZNM1mN1HkKSCuF4ACN5eVNAn
X-Proofpoint-GUID: mYU0gzOAZNM1mN1HkKSCuF4ACN5eVNAn
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a5710ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=WNKottax_SZD0szvUdcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA0MSBTYWx0ZWRfX/UHXiWixdv5s
 N7UqfD3o9nLftd+3nqV7NWVmVQDYRxZxjiWtYqtBcz5ZhQw27hu+UkZcMvHhxBA/ftUuIak09Ys
 pzNLMIHNsBwgCjhI7x8MIqSwXIuQz60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39125-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F6A375A835

On 14/07/2026 00:31, Jeff Johnson wrote:
> On 7/5/2026 10:24 AM, Krzysztof Kozlowski wrote:
>> devm_clk_get() does not return NULL (only valid clock or ERR pointer),
>> so simplify the code to drop redundant IS_ERR_OR_NULL().
> 
> FWIW my AI review agent says:
> Under !CONFIG_HAVE_CLK (x86 COMPILE_TEST), devm_clk_get() returns NULL;
> IS_ERR(NULL) is false so clock_init() returns 0 with NULL clocks stored
> 
> Perhaps the stub function in include/linux/clk.h should be updated to return
> an ERR_PTR() instead of NULL?
> 


Yes, that's on my todo list.

Best regards,
Krzysztof

