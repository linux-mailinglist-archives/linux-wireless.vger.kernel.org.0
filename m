Return-Path: <linux-wireless+bounces-35874-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI7HKQTD+Gky0gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35874-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 18:02:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E24C116E
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED4B3011A4F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305413E1D10;
	Mon,  4 May 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy89RNBM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVdGLp3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0F3DE431
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910404; cv=none; b=quVcYtOFr6VcT7Gr9kqTfnJY4SHarVTai/aEMl334KQ8/0nRdIvfTOmAbqxSjvUOJSyX1jaW+DGGkT3mlEA+d/oRAfDI7mtwjaU10Heua8585sJhKvDbPVAeAOuKdVysuhcVxl4KXfhEiU5DxQ9sq4uTNzjVL3b9j9tDJl87gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910404; c=relaxed/simple;
	bh=VQEzhLGZVsfaNcq63bjYxhwFZSkBc8vCkBhMX7CHcro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsaGmlYbBrl3fIrX7zT9dMyYMN22p2bJ52Kv0KeorVF0F0pQGfCLPfMItAQCKEgh+37Y8F30TyV14Ow3FGFBFvJnsNj4K0pkWxfSnpT9FAmTXid27BOc50uQDHYXnFGWOIPjFhJKMAQLOoSHaCkKyDRVYVyX7D7o+2Bj3BlepVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uy89RNBM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVdGLp3c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644ELnLM1960446
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 16:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V2HNRvXqNJ87AgUJOd/x6U37Oo99yoear6AU07jQsQc=; b=Uy89RNBMZ2MJTW1m
	jb4eZAxF5RvRpq6KkwJEmvtaE9yvblyeaWAbdD0F20XOf3XFQP3JPvqWZ81rfRhU
	LXXj+G+s57HN8EJOcJb7sqqKpiYsoAYkYADuE1MnUSFf9FSBGRoOWHP4h5GLGGoC
	6JggyfFjvBXR6EPIJ53Kl3BXl9a4WMzTYBQoZ7+XpOoBZqE2VSCHjK5enL8AwyG9
	af5l+k4epEhRKZY/2rr8NTLDnBlL1p97/C4OQ78CY8SxQm1hkIvFGH0N6JBFh6bV
	/IemGoDFug5z569FZdZES0kzIVmoYQrXzcQ0UJJvyDVSRlEwTK7m4hmJFh+xkeY+
	sDkPfA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5drcn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 16:00:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so3614912eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777910401; x=1778515201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2HNRvXqNJ87AgUJOd/x6U37Oo99yoear6AU07jQsQc=;
        b=bVdGLp3cmjoRcPsBElL2lKEh3GAVlPFPt4z6Rf47M/4VJqN6sGfdBjcVDT3jYjQreu
         K0WjU84ye1kNgtcllAzxqTbdt5g9rJrpKhHn8Y0ra+lk7rCrf9Lsrl/5tr08A8RyUB9b
         uO6ULHRRLL1JRXZc8gvrBypkwITR6OpLxuWdPEZIrZpwWI682m1BrL+zVMHDzKjcKTd9
         oXKvdWb6OUZ7u+j0JmInoBLDk6B2ZY4KrdELDK8+lMcPbe3tDDYGiyp77wdApG2owpVA
         LOQVZl9aCeelGctrZxJIF61+yAofACiJt0w4sUv3vnkAN/FdW+2KoNi+fge0Y/hmTpvA
         X5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777910401; x=1778515201;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2HNRvXqNJ87AgUJOd/x6U37Oo99yoear6AU07jQsQc=;
        b=gmK/PMZIpzDJtj2X1FJuGIMh8cVUaPVfZsxL94rGbRTkGrufblaHxUcj4gP29YeuYU
         F4NeEZoQlYMAHr6SKG3LeL5dfvoKOBGQ0MzdLiZy1VyqWGvqvM7iYA79P13Bxl3OS5VL
         djzkxnDeo8yJVatuZsrwP3vWj+TmUhtFQs0sxdyRHkbazXhKZPyYEHQ/jGZI2XHgQCgA
         I1c49SmMfKREeXpTJc+rXSEJ1ZAL4i4wFpWv6CwMnK/kraIJJUQqWvQVgEC0SIocwmtn
         DhT8Ww732ePDOMDv4wuCuebJDO5MKJEmoJHs0yW+8NRiqaAFI1N7xs637FDHHOFV7Vvo
         uiWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HTUEDmFcHAhMl5+k2ys+RPPaPiV12VZjJdFNFngBHbZa12TJDZHdVs+MVWZmxuCEftGZieRxJ1TmP6d9l6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydVebuRu8MRbnw7nOipdfOoSkWhO4DmDwaZtycBV3YxZchQDif
	IUx/hvg9Kp/7gDGuY0GX9sM5EEB5WT23Q7bpCYOUerdP1YbF26hPs16Se4ST8hxGPnJi6fZXeni
	9jbJfBsB1Vubn9xXpLPWRIUGOGDj1H1Qqe6DSfF1jXN2bvVPqWeNEW8z9cInDbMrJ9TL4fQ==
X-Gm-Gg: AeBDieviGTv5naLFETPplNRfBHYhI7O7WIZaBXPA2UGDEYVTP1gS3vW1R5EPlBS/oJL
	+C6s8OeOJ0/ZBJWBVEVYasjZnDwIA2Cv6zd6mlRskQodKPQh64LQSYHS4lVPvIyhlvQU/mXsGh9
	4VWjadrmSPGpdT5g02cWto8diQeseyuKGktxjEbkSw2jL9a3VIcZ5lwY51ZHS+8jzLufDgfk0b2
	LaQ7vT5Kn1gp/XH/4ISsSqSVqJ/WbQ8jID2QGVDNer7Xr3Un2A0supJUxcw+doYBVzzfJ4G7X8W
	pkCYE1GNJl6Hp5s9ERevX2SBV9bA2MD9GUqFbvqTef++HGr5RU1+7BzRCbB0Mn6inXnHYB6KIe6
	UsyzWTHga2vlBbUyyzYk3VYseZgIl9tXNX58VpwDxYOQhGJAY5FQGH5bVP0yLmy9CXHBSprujYM
	yLIuLf60f+kV1bwhHFYLToBcHF
X-Received: by 2002:a05:7301:df4a:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-2f3cf2eedf6mr31999eec.11.1777910401144;
        Mon, 04 May 2026 09:00:01 -0700 (PDT)
X-Received: by 2002:a05:7301:df4a:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-2f3cf2eedf6mr31984eec.11.1777910400611;
        Mon, 04 May 2026 09:00:00 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6812asm16154262eec.28.2026.05.04.08.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:00:00 -0700 (PDT)
Message-ID: <3358cc85-4149-4136-9418-da400cc8be72@oss.qualcomm.com>
Date: Mon, 4 May 2026 08:59:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v2 0/1] wifi: libertas: fix bug in Marvell Libertas
 driver
To: Jakov Novak <jakovnovak30@gmail.com>, johannes@sipsolutions.net
Cc: dcbw@redhat.com, kees@kernel.org, libertas-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linville@tuxdriver.com, mingo@kernel.org, skhan@linuxfoundation.org,
        swilczek.lx@gmail.com,
        syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com, tglx@kernel.org
References: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
 <20260504150416.4853-1-jakovnovak30@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504150416.4853-1-jakovnovak30@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfX+xN2qTi9Rbs5
 RGQr0OfmplZKO8KbJw2u00Ev1QSfIfO095SDpheK7GqfrdFZ1Fo89Kx1e+HOSoWt/EnBDFe0lVo
 r9BP/bOOFkDFSjGN5WCXpKzA8WdttuTnNIWiJASDgfFNkCP8iC27UPku+t045rlC3/lpHt2Unbg
 ot3zVc215/8qfQ5HRqM1q3NJymGFPxRFK6dM1IdbwjmaZxKKzxKZ5nzUnh1TUz7IXQGQlT3B+bZ
 pLalc2GRKyN36nS/W7WiUCUP9AJ7RSDoOlbt1fb9b+RDQxL+5KXeSQxO3A3oaKD9Xsrd5oAS9fE
 p7HMnuGkHDdtGJmxF1AQ8Lq6ThqqzT/K4CyZg59vKaBZzQ6yehrGjY+q8rCK9Tj46eOFs5ifMjk
 9T2ZIlVhSxs1Hepk+z+BWKVns/oPrRS8xdgv6sSJpZnbCPqZFSF2sdoUK87kgDnUy2lX3YNMq/x
 TyzlV4kIqY9yDvvB7BA==
X-Proofpoint-GUID: LFBNUeWWALZj_X53vC-7tQtMqF0BMM9m
X-Proofpoint-ORIG-GUID: LFBNUeWWALZj_X53vC-7tQtMqF0BMM9m
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f8c281 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=BSlS3vGW8Tkd-czW1RcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040151
X-Rspamd-Queue-Id: 1D2E24C116E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35874-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,gmail.com,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/4/2026 8:04 AM, Jakov Novak wrote:
> This is the same patch with the suggested tag and message fixes.
> 
> Jakov Novak (1):
>   wifi: libertas: add wake_up() call to properly notify
> 
>  drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 

1) A single patch doesn't need a cover letter
2) new versions of a patch should be a separate thread. Don't make new
versions "In-reply-to" the previous version.
3) Ingo Molnar once suggested a good template to follow for many
changes:https://lore.kernel.org/all/20131111113218.GF15810@gmail.com/
Over time I found this advice helpful, although not that exact template,
especially given that using "we" is now strongly discouraged.

I suggest something more like:
Currently, when <scenario>, <code reference> does <action>.
This has a <problem description>.
To address this issue, <imperative action to fix the code>.
<Any other comments which support this action such as describing how it fixes
the problem, how we know there are no side-effects (or known side-effects or
limitations)>


