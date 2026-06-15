Return-Path: <linux-wireless+bounces-37816-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1AlaGVTaL2rNHwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37816-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:56:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB96685862
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 12:56:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=OHupq9ZQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37816-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37816-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 580E33009F54
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F233F8D4;
	Mon, 15 Jun 2026 10:56:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5836D4F3
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 10:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520978; cv=none; b=VnUIosp6PorxD3Szci1gbuKposr6cArNImgLcsgkYx4ZzjjpZQdD1PZCSRTm4EcanQX4GdS5dsgOhfYFKxAazuupAH4COaTCaBiuHnzaeKh0RMSOimWSHyQkj6pIzkh6Q7Prnu38d0RnzXrNQd+73z3T9tXMku6HsGG24Rp8Ddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520978; c=relaxed/simple;
	bh=mKt6QMwuWptG2VcLJuLCIC4RSKSQxvPO5hzB8Ulm2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4ezJhnYDoqR71cMCLcS/pNHrPj19HeqW74SvB7WOD8mWBTRmIEXbMum8Pd/FBFWPITUnzJkZKERzvZbNIgT9jIKAkkERs4iai4XouyZFRXAQW5SgxfOenReCBgIfp51oUHsh3MqSjuWeqqof+cOH5NtM/APRcSka8MCKFNsWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=OHupq9ZQ; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2000762a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1781520977; x=1782125777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrB27YZFrFGdQOeztFI5Q7wpRYW+ZU/svKmcGuMzHtI=;
        b=OHupq9ZQBlt8dvGndGMXRuPcwiWZLlDctD+1paBKWZi7xD6RFT7DCyHXDbI78tZ2t/
         wOrTlHRlsl5dC+U+35WZxVhDt8DDbAot2cCGE13BkiMg2y50hwPnQp7GfSOfQDHn3PJv
         X66Kfeywb7mIgWlwr9A4Ud7xtscpyb310QBW0irV/Z97AXx6rmN5orMvVOMRt9A8HdOl
         LH47bikZP6pD+5NBS/+koD1x994SejG7YE2uO7YS237WSXacks+NuTTwwP09QHEmVz4i
         BMhIbYlcQMx4Zi8LpZPmkeBt2rdbaPNPPt7krHGR9vh3oNPPjhaeeVxOEn9UsqWcLOsU
         RuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520977; x=1782125777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrB27YZFrFGdQOeztFI5Q7wpRYW+ZU/svKmcGuMzHtI=;
        b=Lo69GiGtwoSzyuB89d7Sw9NxIUY2tDTXcjIRWjXurcDiGcNyCq2SmcQ91D4dVmQwcq
         P9Zk58nZYvsmc6kFQuB6dw/o/OvLhRwCAu5b6vf35lVgwXUyT/ypNv0NG3qmEdFMJCj4
         Pws4LIeOnDkttviV7LIVhyLOH5CtbP/XoeEOLELGVf5an5Z5H2Hlmolql4pyljPeatDJ
         PzZ16w43WC3kilnpm9ooMSh4QYMzps0hNqvOd6+vtWS2B/YfzC6J9239qPoNxFl/52fG
         WrHrjdzfSc1sweQh4KqmIxg5WjKwOvAEhzqQ88p4xx+uwCPr6lHsbRQF6s5kOjiDOA/W
         tJ0A==
X-Forwarded-Encrypted: i=1; AFNElJ+WxZGr5ieyUalY1ZM7FEMCcdW3J0HDT02MAmCoa3re2es8RQldHi7lLpZu1Ym7BuGlgY2c1RDg6X17pwK7Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzxPjmtKDa9Slo+tzKIWVxBHistURdg2Tq0XbbHhddvhsR4vm
	Lp/R6So023jiI2eg7IAV71RNe1+laTuvKACFunKuoTAMGlwOy9ffuMyaZppSLKWAAcE=
X-Gm-Gg: Acq92OGiEQXLQSan0WAAoO5Lr7iNu8I24JsD6S8mEFIKu9kEtqgVeobCCXbWUM5/gqc
	j5io1zhHku1umAPu3Hfva5rAnsNzmjNTfU5pU/nSuT8iknEeCHrbJ6ojuRuGrMpF34HyEYBe2LY
	hKOri3nZa3beq8zbTVx94k/eQ1xvWdT0FxvbiAMWbCKP6RCCXC5zjYeL16z/oJYxj0mClDDxRka
	vYcZHCjVE0eoxqSoAg0Ffho554pHGb4IPaQm7wfJM1X5yqwFivZxbzh47k0mt6AIuFeUoS9hZbR
	ZJnB0h2TomAHU1GGWN5RXxwDFoodeoi95/v0J6TygBTcDpSH5qP02seFUFASXcEaNRqkH1aIHSK
	pnf4FfSJXl/aC7IAOvcEYlUvJRidPlGa1XxG/eQM0QH+oNNa6kKVggTTaegV9eesDKRVbeuCppV
	Gm1EiwiB38i2XUfDdPfGUWpOh6/Ysk0rlkO9WauNCds/5Gxt5hkFXJV1k33QXbHVkrj/xPIsbdf
	NE=
X-Received: by 2002:a17:90a:e70f:b0:36b:5b82:4834 with SMTP id 98e67ed59e1d1-37a01e2f16emr14891535a91.7.1781520977093;
        Mon, 15 Jun 2026 03:56:17 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f451bsm10243364a91.1.2026.06.15.03.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:56:16 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:56:13 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: meihaipeng <meihaipeng@uniontech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] wifi: mac80211_hwsim: skip sta_add rc update on
 sub-20 chanctx
Message-ID: <5lxuhfwibq63gcctynnr45lqllffn2oe24es42zn26qtqi4u2t@p7iskzqnori6>
References: <20260615100321.22208-1-meihaipeng@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615100321.22208-1-meihaipeng@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:meihaipeng@uniontech.com,m:johannes@sipsolutions.net,m:andrei.otcheretianski@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37816-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c0472dd80bb8f668625f];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,p7iskzqnori6:mid,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDB96685862

On Mon, Jun 15, 2026 at 06:03:21PM +0800, meihaipeng wrote:
> mac80211_hwsim_sta_add() eagerly calls mac80211_hwsim_sta_rc_update()
> for a new STA.
> 
> The warning that syzbot hits comes from that add-time call. For sub-20
> MHz channel contexts, ieee80211_sta_rx_bandwidth cannot represent the
> configured width, so the synthetic sta_add()-time rc_update() trips a
> false warning before any real rc_update() path is involved.
> 
> Do the same thing that was done for S1G: keep the rc_update() logic
> itself unchanged and simply skip the sta_add()-time call when any active
> link uses a sub-20 MHz channel context.

FYI 5/10MHz channels have already been removed and the S1G case
has been handled. These changes are just not yet in Linus' tree.

lachlan

