Return-Path: <linux-wireless+bounces-35263-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGCmArgp62mPJQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35263-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 10:28:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF345B785
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 013FF3004D0C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A046D37189B;
	Fri, 24 Apr 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB2mSpC9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50424372680
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019312; cv=none; b=ItUBYPLlQ5vHkJgJuV36hUGbYc4W2R4pvH4XQoehL3uqQyxcW17cAWgtIAGXnw8PrF8b6iyIvdX3sGmLDKg0wMFO27+UmeDdQ3+XrtbEGLJ66rQUT/Ewj/n7cw/9GSXWlTeAbTV78TxqcFeXUcfPTS/2FGWWsPT+rn6cq+rz40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019312; c=relaxed/simple;
	bh=ailI1wF2pNRasu8c95gpG9miB0ahw1GlCBoC5jlD4IA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lH5foz0Z9Br4Zho1jg7gMnYz7K5GOl9ulm/OhIam/vPLaW85rQpfURApChfg0n0Kk1P7BeBCjJuiVorDGBFmuKtMorRnrQTD2DqQGe3wgMlYe6YWSWDdD5FSn3ILQCr0lpDnppoYLL6gJmTlRU4ENJZ8DOaVLRjZJAyIYM04z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB2mSpC9; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca9d0d189so738773d50.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019310; x=1777624110; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGJw4p4zc/LBxIIehflMAZOYDqiZ8foxr3uiLsiGgQU=;
        b=OB2mSpC9zVHdepohTz/k87XK3B405YD7J83HQ5o62vRO1DA1Y40d6eLbjVTP91JbeF
         kgg9/S4t2afiO1f0cQ7U3K4P8VJO+nOxvfCoGi5Gzkka/KMg9rscGmJz++tW0AvsBO6Z
         2JP1hOj5r5XCXNPmUXtV0FzboI95Zfpcv8dwgDzKI7p02eol4yHiOTzKPcrh5BY5/3i7
         j/0UdNWEQkUyO9/P89wJhoHH3wk7s1IXY6awF0i++H7MwDNoHLJ3ANBt7h+woYTIx8bf
         C8oO3dSq2TGPB0LORN7SgpoMDLmB6WdJSgwE0bqKutuz27/sGiugXc6QSbzo+Siy47bP
         vEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019310; x=1777624110;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGJw4p4zc/LBxIIehflMAZOYDqiZ8foxr3uiLsiGgQU=;
        b=FWzNyIuBrwJyeVmMDlmwgAKl8gCKWzTpdh49ZkgZLkD61EJrRTZZhlsrRBBAadKLqS
         81tYbwyRKr49M73/5hYqxmm0R6jEFIhDNhnVM2n9B7d/suWf2n5reX2CeiddKr0l4yqX
         0g5i1W4zEVvMI5IF8ZzsnliGSJRYvNHc9pm7SnbWixikQNripXJIP1HPfAsfCdkg3JjY
         /YOMIOCW/JOAUuGmVJbHx6O3HIg049RokpxStSCGUT159e+/ae9nCqG/638R4uEPUKyP
         v8iEgekaPhUioEE1NMOcl04uZy1hdo6Fm1FcCROrLjPxEVb6BUMcf596vTtZE8b0pWRd
         J1ew==
X-Gm-Message-State: AOJu0YyeqwQCAlsJ06X1WYvNRk3/vaCWOTgtjH6oIV/21PaBcszcIHAB
	uEjm5Md+ZyHNw63J1tQk4Gg7NkJstEhd4Uwi6WVQnpH6GNs/N+lfYBnY9Va8wmnZ
X-Gm-Gg: AeBDieunzlerV0lN0Z0ZfOiHH5GMS2UcMehuOgaw2hDKch9hI9TjoO1fItCQpzCqWxP
	OY/cO3ZYDDKJ7GJHFexlfdzFkUF9n6ph8MBAfAKioTAXZ9ElBl1CbNwpfvDluwnDZGMrYfbKFeq
	TZZeXETmT9gWjRCD/xJD5iPG1SrSr+uqkPrGVIht9TrtZ38Gg7f8caMaFaWTfqyFAGPapX4HJcK
	x0wVN2djXuztZe1YnuFsoM9yO5ctPgtqsRLQ3kNW6MJbzOj9XX02p8jxm4XrJalRlSbzQrf+Sqs
	K7a1aAqgAlhlm1GROTkcZIly7kct66ZrSHIdgJA8aEgG5C/vU2CL+18iXh4/gqB4K967AV0XGb9
	pcJMQmf9iEQ75ipMIIRZfM5004NoPE7S99NvW3qvf/PRy8BfxxqQn98Br7PkPmlXTUN1TYRFr7f
	CId732tt9dy8QeBlT51jKuzgaz/5BKFsTXMbGZgnGmmHvBMldD9GCkVyP2Q/q0Vqz3iYDN+trbf
	3a+Clp/GVkICkE=
X-Received: by 2002:a05:690e:1914:b0:650:77ec:6a27 with SMTP id 956f58d0204a3-65310c3706bmr19507811d50.8.1777019310006;
        Fri, 24 Apr 2026 01:28:30 -0700 (PDT)
Received: from ?IPV6:2601:ce:c180:9af0:e7b2:69d1:2d5a:7b37? ([2601:ce:c180:9af0:e7b2:69d1:2d5a:7b37])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b2845asm10434231d50.3.2026.04.24.01.28.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 01:28:29 -0700 (PDT)
Message-ID: <db830769-2681-48ea-a8aa-f4cf8f3dfa4d@gmail.com>
Date: Fri, 24 Apr 2026 04:28:28 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Jayden Fowler <jaydenfowler831@gmail.com>
Subject: mac80211 HT/VHT MCS check change causing Wi-Fi speed drop (~20 Mbps
 cap) on iwlwifi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5CF345B785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35263-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaydenfowler831@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello,

I think I’ve run into a regression in mac80211 that affects Wi-Fi speeds 
on Intel iwlwifi (and possibly some Realtek cards too).

After testing a bunch of kernels, I noticed something pretty consistent:

Kernels with this commit Wi-Fi gets stuck around ~20 Mbps max
Kernels without it (or after removing a small part of it) speeds go back 
to normal (hundreds of Mbps as expected)

The commit I bisected it to is:

574faa0e936d12718e2cadad11ce1e184d9e5a32
"wifi: mac80211: add HT and VHT basic set verification"

The issue seems to come from the new HT/VHT MCS verification logic. When 
it runs, it sometimes decides the AP’s advertised rates are 
“unsupported” and then forces a downgrade in connection mode/bandwidth.

That downgrade looks like it’s what causes the big speed drop.

When I remove this from `net/mac80211/mlme.c`, Wi-Fi goes back to normal 
speeds:

if (conn->mode >= IEEE80211_CONN_MODE_HT &&
     !ieee80211_verify_sta_ht_mcs_support(sdata, sband,
                                          elems->ht_operation)) {
     conn->mode = IEEE80211_CONN_MODE_LEGACY;
     conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
     link_id_info(sdata, link_id,
                  "required MCSes not supported, disabling HT\n");
}

if (conn->mode >= IEEE80211_CONN_MODE_VHT &&
     !ieee80211_verify_sta_vht_mcs_support(sdata, link_id, sband,
elems->vht_operation)) {
     conn->mode = IEEE80211_CONN_MODE_HT;
     conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
                            conn->bw_limit,
                            IEEE80211_CONN_BW_LIMIT_40);
     link_id_info(sdata, link_id,
                  "required MCSes not supported, disabling VHT\n");
}

This is my wifi card i'm testing on Network controller: Intel 
Corporation Dual Band Wireless-AC 3168NGW [Stone Peak] (rev 10)

Thanks, Jayden Fowler.



