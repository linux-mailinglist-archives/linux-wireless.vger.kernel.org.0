Return-Path: <linux-wireless+bounces-32214-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEQdDnl/oGnWkQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32214-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:14:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD71AC014
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65A28341209B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AF368979;
	Thu, 26 Feb 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y2woUKDz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCA4Ir7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640335A3B8
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125134; cv=none; b=PIRDD8gwPalnrnvqZKvnj6KTgRgFKle0h54dUmP+3UtL3zsu3rT8D3s++DnsmgXqAlbMZvFZ0nRR1hRU2F3qeT+MP1dW3SbC7kVBPowWRty+Go5PgVe54fv3b83ef8NujcQFdbAPlPhZG6Boa6mJQZK7ITAphx0F2JTJUgiIlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125134; c=relaxed/simple;
	bh=Vro07zPgHay4FukMX/5jm0SFWMb3vz4/6cTi896bZ5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f38Gnhpy+aIjuu7iiOXAZCDd0vqLGwn1/X3w2eYGwV1S4J1rwPy1ja9j0yoPAtCWIX55eE3d4yZQw2xVGc0ANwno+RCWX/YUsDScLrOaUQp9r17iI3omx6//Aato8Eh6Zp71dxA9lSUQWanGT4es5ZdlhPP9Z/dCqm2tdl8A/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y2woUKDz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCA4Ir7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QGiwRP1204763
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xBBoIC7QrgePlR8OeMHS8IubOtLbPPxxfMkMdzP+WuY=; b=Y2woUKDzmHTez7+E
	WQLJdyfZZanXs6dQ/AcovNtbMAGj+NiTXC5VkVf4vQhOoSxICjcXHNt5b78porG1
	g+Wua3Hliunj87NQog9wvywMFFpKZ5dRvhDNhp78OmPjmktQ2+XgX/3lSh9CG6Pm
	WbUq2fgkQQFVqLLygwKgWiBqi10vbQWO4+04tzoLht30ETTPz2RYM/UDPWRpu8Ed
	EwZ3BScw2usDX3U5vcdldSwGIgdCO6dZLNpdASm6Fc50VE5+OhPWPu2Za6DyVmd2
	SXeFDlPRWgP2BPZ4VCVF+IaHxmQCMsyNUaV6qNyjZchZBJo/z9Jbnse2SO8L+3hS
	AYKTLw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj8bdbcks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:58:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bce224720d8so613834a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772125132; x=1772729932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBBoIC7QrgePlR8OeMHS8IubOtLbPPxxfMkMdzP+WuY=;
        b=aCA4Ir7LiHpNy/ra5PfbjgjRCFk5GhIqpQpn82mRkM+mQTwZ/djivrwLZZpvXeh+B6
         84myunS80zRjUOLeowjsItMYR3HOBTpAlJmPVUE96Sgyab+T+lDEnqT1f9SMfZZvvPV5
         Z8RZ86FTN+bA01CmnM6IqWJX/2yu0lkKyjnvigCaGrdo6KKWmL0bID/F7k8TrGRjEZKn
         kg9M0jsBJrgILBc9RbF65Rwmk25HCjg5H0QP5ROXPYH5cZOc6E+95xc5yzcTZlGtNzH/
         7/1TraxLR/zPPP1OezWjMRw/wx+tSeA05Ot/jJEhjOSidlMXnfI2orr1qFsU07/EwXix
         cN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772125132; x=1772729932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBBoIC7QrgePlR8OeMHS8IubOtLbPPxxfMkMdzP+WuY=;
        b=tOzueP1YBRzL27hVdtLU7zuzp6hhOXx9mdEKDRFOrOO8+GJhmxkXnMRH3f7JeR/dLe
         xTcCuyTgB7xakWWE9eMQukdsZgsS/ACi3A/g6G/LY5ms5hAaq4r9Ovyp6vlE2FIi4wJ2
         yVgKITIybgkmlBxLeYluXfzQpaxlPwpveIWsIhCaUcsK2KqThaEGm4Sc2jHRZELsSFvy
         DJ9b+eTmiHzAnd4uWZ1quHakdOzGxoPwdF64q0O82d5k6MfiPGrl4aTLKPP+FpPyuSdI
         zmOYmEsBndoNEXl87F+pdphl4NbDK1vONEHLOZ961jMnlNnPCiZBV1vAxJ59c/Ov4OHw
         YjXQ==
X-Gm-Message-State: AOJu0YylB/4jj/YbWYBee5rQdC9OFViZb/2/OVwCIncx4AAvKQgIG9v2
	tJAjVtkdb/idCG2pg4fKRglHTp0pBxPCebshe+a2k0dxrGLuuwlnHZH6x8f55H5ay81jwMJOahf
	37DpT4RynupZc8j002UcFQsKpuaQhfVxql+WO6WBOef5JwKPy22rfLV7Irf6fxLNNIk6e4vx0Jb
	IDpQ==
X-Gm-Gg: ATEYQzxcxrpmA+weyRU5LRi3tuNI36JTdxe5hqvZVdrLQM7OCaFJj7U/ETFxjGeGKnn
	qs5i9IMMeCALGRi05sg6pzstu8lJ3t8DjgjT/Knsvaf7nM3b/gDQkkyDyMjhu0OoG2v3m8b1aam
	VPqx39K/svhgmUxM8Wom7aRjNa8r0qyqwnLAWsxHGv3QO75P2Y/1WV9pbmp9lxXFLJJHBIR+moA
	gpnt8zKfS/E+p9LBzQf67xCZf3J88xLEdUP7EM/bZgivEmGN2keP1yz/HPgjmOrjlCiotAEj87H
	gnaP2oSRNDKPHUM8is3lvHkdidC88OsW3582Q/pVccJgSX82g4Ai9A4ukJYi3S2H/CSp9x81he3
	SFxk/8SuUyf8Ow8qq4EGEx+3e+s17+Umw9bHcGEGL4XM3FsZOxEhMBjU=
X-Received: by 2002:a05:6a00:6f12:b0:827:32d7:668f with SMTP id d2e1a72fcca58-82732d76c39mr3625438b3a.6.1772125131227;
        Thu, 26 Feb 2026 08:58:51 -0800 (PST)
X-Received: by 2002:a05:6a00:6f12:b0:827:32d7:668f with SMTP id d2e1a72fcca58-82732d76c39mr3625426b3a.6.1772125130701;
        Thu, 26 Feb 2026 08:58:50 -0800 (PST)
Received: from [192.168.1.10] ([122.177.243.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm3623793b3a.43.2026.02.26.08.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:58:50 -0800 (PST)
Message-ID: <67e9955a-1287-4467-9b52-be89144effbc@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 22:28:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise support
 for IEEE 802.1X authentication protocol
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
 <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
 <e96a1d08ab71bb75bd7a65278b04d29c609904bf.camel@sipsolutions.net>
 <15cd54d4-a663-423b-b4c5-9a058f5bc73d@oss.qualcomm.com>
 <916b0969c559f1faeba94bdef792da646b9b0c21.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <916b0969c559f1faeba94bdef792da646b9b0c21.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKQWBuos c=1 sm=1 tr=0 ts=69a07bcc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=RvLD6kXmVJWkDpkbezg6lg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=qLqdC-75dL7bZc4w8gMA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 1KzLqFF_cnaTc9a5yngicoiJpbKIJQd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1MiBTYWx0ZWRfXxp/XdDxWPJy1
 +7GfJovPhSzjBQ89PrBJGhSIPggqB9DsLO48qpLduJtIsjl8hLTKAIWoTnII2pKgDkw/m8VpJE3
 JwJnlv9AcclboJvOS4JwvZM8HLKYMLw1ExcpxQxYx44BRhf15ARmpqHulVOtD8d1bSi/LrZuygI
 5n6OgVDpsPMdNWh1F4ros+6zYi/hK7ClQPFJlu+Y6hVO1djFmy/1XrGpYFp+AqVKwSnlRcWMKvi
 G1OAimQuJh1lrcm/RqHv+tkRNZMYdODmdfWYLdk0AdWtVhKtcg8MjJnwvOKbtxlJKa+TrKNjFJ8
 5HMQyVhfO2EJK3GttD+ukm0/VkApXoKWfQYFgDSxE9Ly9GDX3PpiaQIqek1Cq7IhidFTMMuywnq
 vm50TlTLtL2UAPLhELZ9hJ+SQJnbKKg/JhzVpylN5hyd2y0b/kcnTypHidZVCl2id7LWSxScvq1
 /g7rCKdl2CHd3j+K9Cw==
X-Proofpoint-ORIG-GUID: 1KzLqFF_cnaTc9a5yngicoiJpbKIJQd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32214-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2CD71AC014
X-Rspamd-Action: no action



On 2/26/2026 10:20 PM, Johannes Berg wrote:
> On Thu, 2026-02-26 at 22:19 +0530, Kavita Kavita wrote:
>>
>> Sorry, I missed one case earlier. EPPKE mandates (Re)Association frame
>> encryption support, so we should only advertise EPPKE when the driver indicates
>> support for (Re)Association frame encryption in mac80211.
> 
> Oh, OK, but we could also check that in mac80211, in register_hw(), I
> think?

For EPPKE, I will handle it like this:

@@ -1598,6 +1598,15 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
                local->sband_allocated |= BIT(band);
        }
 
+       /*
+        * mac80211 supports EPPKE, if the driver supports (Re)Association
+        * frame encryption
+        */
+       if (wiphy_ext_feature_isset(local->hw.wiphy,
+                                   NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION))
+               wiphy_ext_feature_set(local->hw.wiphy,
+                                     NL80211_EXT_FEATURE_EPPKE);

For IEEE 802.1X Authentication, I am thinking to advertise its support directly
from mac80211, in ieee80211_alloc_hw_nm, without checking for (Re)Association encryption
support from the driver.

> 
> 
> johannes


