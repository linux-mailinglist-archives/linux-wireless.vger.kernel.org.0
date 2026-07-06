Return-Path: <linux-wireless+bounces-38669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ASdlBz+fS2q3XAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:27:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6532671082F
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=iMFR0wgo;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38669-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38669-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F725303EC39
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650444213E;
	Mon,  6 Jul 2026 10:25:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE362E7391
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 10:25:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333521; cv=none; b=e3Pp2ul4WYUwfP7hDZFXjQmjKoF3SoZ8MUrlZpUoaNYq/eQ1UlFalRmbrKhuaM1CoKOmqXHaMjA3fbTOzCXYADLLm2kZrNroxdDvmDm2vp1C/JadNgzJZlY0SXrcxbIyYIKsj6hLeaxCDXpgctTxln0d60E/pir71cpyud6XIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333521; c=relaxed/simple;
	bh=DEDRVzDaeKVLrZDEM4Tvl5Zi+XQvdZFjkOH2bi8Q7O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3mER3+LHTKy5pVYOMLRGeeszX4tTHTF5IPiCu1iJtyUFAmvjLyYBPqIuL0kkgEOvqzJZSbcDRjiaAXl2UXCY6+upcvkxFlD3Y2fR3W3MLeWCD3OTA+/4cINtqhawKQXA8OY93yiBFnwn9vO/uPkrZISPS4ViAoU+GW/w/SywXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iMFR0wgo; arc=none smtp.client-ip=209.85.161.99
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6a0e525db1eso1919080eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333518; x=1783938318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCyn3khAPieI4DeaZVrUFyliHAMCDDeM6OYmHqd4vok=;
        b=r1EIRKSzvSeWsv+/SZ7elC+Kz083iReshOBkWvlBdMvLkID3CHAmmbLkn1qakzg9WX
         pzzV+F12GKJtPJSGMCZzC4cI/Q2afqcMlrp9c4ZIssmcBTWx4d6kcezFIKJJM+jm8YEn
         PRExY0Pl7n7nNjLAkxe7wyy96R0iaHvi0NVfmfu9te9duk8gyB9aFXPZyc9Rc4s/0Y8J
         bylroEvx9u1AbnCkBUChCPOoiNS3TLDX6HWamP81TvEQTTg9JhnqtOt+ElT5k9U1jRrN
         yTxUO3FdTKGo4rEdAUUwIRafcjTPL1CtNZs3zWwumY8VtzBJBb+eWnIykcl2B0HWov34
         XA+A==
X-Forwarded-Encrypted: i=1; AFNElJ8Umnb2gDd0VZGyrRi54WA6wPUhyeuH3+gIC1sxQfzC2zjtV+N07lfzrLBPdRb2ZdDena+ocDwbxEPkXo+Law==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/4w7M1+5PgkpuVzNJA0CXZ5pi4hkPNV0wxOs5i/iwaSsmsGT
	5fN8feETHbB+ZL1Z2WP/Ea5rAZEPpkq4npYhtWfVHkQGIv2vhZvKL3zPfTuCEYxyaNkSpQ+h1sN
	p9+z907xIeYHacw5b/T4gUoIRl7GqMSB146WJ9SmWAk5cWFIlcIQ93wTEpsOTh65zjn9ItiTOUC
	RwX4puctw0ZPIYCjY1lsUwRRPScWxnYym3GZLbtmYWfizk9m3fA553L6hRmTQC0/gJDWcRaracF
	bIVm1t0Cc5o8OUljP3CalhKr2gP
X-Gm-Gg: AfdE7cn1BOinBOk7EimiaxoSWErIhvmQs6IBMNIZBy4c2q8qfNr8PICRtSxQySEvNoE
	L2NDqmRzfT7+RR7tW0xCKt26Uw4+DScqI+LfudHNeJ6wz7OH3vtcUj4b/TV14Ge62Hhr+eOHPMW
	YpvdsUIaWHH5RnFPH5MNixMbFKyUG57HJOs63p+orqA3BdS8Cbgoju3jh4I3VRyZ9CM34v72mTh
	pu0/1VsICyTzw64XE7IgvOBFUvnsBWLFq/Z9CYwFW09M8uNAvYhtfpNrllrsjqI6c8tvD51zUpy
	XIxp/JRJVed9XPrz58BWvpsL+6lcFB1IdRmAkPc4Ue99LxVK96NKtV5mfd2APCy74tpS/WgYnly
	sLV3mqSd9faTrcv9O4DsqG8u5ZmrKHQoMShtnH+01RnX7I+UKg0PGr0hvTfExlgTWUjI6Qxdqw5
	hXfW2pCVRuABib6NQ4XghnZ0JUhtOIu10R8q3pECeGniI21uEVxUo4
X-Received: by 2002:a4a:ec4a:0:b0:6a1:98b8:88de with SMTP id 006d021491bc7-6a32f570699mr5039692eaf.44.1783333518049;
        Mon, 06 Jul 2026 03:25:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6a30ffd685fsm795043eaf.5.2026.07.06.03.25.16
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:25:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f946461so279364585a.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783333516; x=1783938316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCyn3khAPieI4DeaZVrUFyliHAMCDDeM6OYmHqd4vok=;
        b=iMFR0wgo/l9eKgO++QclujbRbIQ0llwJAf07oEC3GEtInz/WWlMY6WZAy1y4cVGdlm
         6l1APWX9sUKNNtY7iXAoC5HXmYHmfYWN3PD+SPned10ZcZACCvP+Uv+zm+Uc07gSNUSs
         u6BnKHoM6dkGfGiMlZGtDUXPVzR49ONbv0yLw=
X-Forwarded-Encrypted: i=1; AHgh+RprbJUdEr/XP36t2WajHT4sTEGwZHwjuwU4lD5y4bdts8GnUQZ5lGjVoTAOkPZDJkdhIhGj9WTbtBvfAffDwg==@vger.kernel.org
X-Received: by 2002:a05:620a:4442:b0:92e:5856:bdcd with SMTP id af79cd13be357-92e9a49ed00mr1318060585a.53.1783333515797;
        Mon, 06 Jul 2026 03:25:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:92e:5856:bdcd with SMTP id af79cd13be357-92e9a49ed00mr1318058285a.53.1783333515309;
        Mon, 06 Jul 2026 03:25:15 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b804ccsm900041985a.10.2026.07.06.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:25:14 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Robert Garcia <rob_garcia@163.com>
Cc: stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Mon,  6 Jul 2026 12:25:12 +0200
Message-ID: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528055431.4124445-1-rob_garcia@163.com>
References: <20260528055431.4124445-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38669-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rob_garcia@163.com,m:stable@vger.kernel.org,m:duoming@zju.edu.cn,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:dkim,broadcom.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6532671082F

On Thu, 28 May 2026 13:54:31 +0800, Robert Garcia wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
>
> [ Upstream commit 9cb83d4be0b9b697eae93d321e0da999f9cdfcfc ]

[...]

> +	del_timer_sync(&cfg->btcoex->timer);
> +	cfg->btcoex->timer_on = false;
>
>  	cancel_work_sync(&cfg->btcoex->work);

The upstream fix uses timer_shutdown_sync() which prevents the timer from
being re-armed after it returns. del_timer_sync() does not have this
guarantee.

brcmf_btcoex_handler() has three mod_timer() calls - two in
BRCMF_BT_DHCP_START and one in BRCMF_BT_DHCP_OPPR_WIN - none of which are
guarded by timer_on. A work item running between del_timer_sync() and
cancel_work_sync() can re-arm the timer, leaving it pending when kfree() is
called.

If the mod_timer() calls were made conditional on timer_on, setting
timer_on = false before del_timer_sync() would be sufficient. That would be
my preferred fix. Alternatively a second del_timer_sync() after
cancel_work_sync() would also work.

Also the commit message still mentions timer_shutdown_sync() rather than
del_timer_sync().

Regards,
Arend

