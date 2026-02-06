Return-Path: <linux-wireless+bounces-31616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEL5MaGjhWmSEQQAu9opvQ
	(envelope-from <linux-wireless+bounces-31616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:17:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003FFB5B9
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C8D30060A2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87E30ACEE;
	Fri,  6 Feb 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQleK3KE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96020346FA0
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365850; cv=none; b=kZbAhx6o4w0BKb6p1Ta72cEfqS8JQW+f70xxrCkkQ3vOmLdLu5ugihzY7TfrzvKHmBrHPS8DsuPERnCIKWdUbepy8gsCp88dGjkFwgFXZaRTY3QzHdWxWeJ+Xne25Uqep1dvAq2lqgAWtJ+TgpP0wFmSJwENO42RCyde2kUiHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365850; c=relaxed/simple;
	bh=gb/41h5MRU2W6jC2wVlQejq4o8CjoXX3e4gitw1aRWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XYEWYkaWpyiAgtIPvCQdIQdagz5DJbNXXzir90SgeqyEcVXG39bH45fHe2DqfokrxyG5S1+j2TgAmPHmLJz1zhYKQpCeX9mXbSfFDoR2Ftho5TrcFzeQpVnjmTGTxZ8QaEVqHh+YmIyyTagWL8dqHyP6yKh+58HLciQakb39/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQleK3KE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362c63531bso181107f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770365849; x=1770970649; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gajt8Ye/gxNLcADKeCuVEcNyp+odOWE8Rn1eHmBgWYo=;
        b=uQleK3KEnwkotEF72GhcXIhQvYp+rMUaQTz+jrDmaKqx0m0cbGJBb5p6xOrXNi+++n
         hBS2FTplpCrFE7cJPyOSXUuAqKcookC98kJk5UzYC2eW2aVb2R87ItdWVIAuokg/8/XC
         ihEwBeGVBZk2BXFSeWTbZf10KbYLOjQeoE8+z6X/MDlEMu1ddefv8wgGSylADFmOUXOM
         i+1AM4Fk4XK6RfNjEl+gPcaS5l3TVT4aF1zW9PhGI4zKek0dQqo7q7iFPbbSNKmNbxSj
         ICfxH5BXAn4UPrPNMNo+GHiICHag3ZDdWzFGe0R7/MXiLan2IXp92/55cZiAhwLIX5Eg
         ipAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365849; x=1770970649;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gajt8Ye/gxNLcADKeCuVEcNyp+odOWE8Rn1eHmBgWYo=;
        b=Alpva3A0RXpsOXtp/vm4jW4julxg6Oxxa3PdsKUhUDsHJ5C3+RQT0QiggdDpFpEH0k
         VK+cygSnx8FxgafI8eKi6AuGfcfTuJKfwjvLAXEKhyoc/l6eKkadaqEplWda9B3K13nP
         o+KrrACASPqaumqq1qYwBnUYBRCzZENgCWB9HS04SID6VMQnk/1Pawz1nCvwCDjBzEtj
         FY7s7tlpjP2MDnOG04GimMLRndtsx4TQqEq+lMx7XBgeLoLrlCivbcCs++/2mHFQ4KPo
         pNaVKAaA3u7AxMwxlmwchTddDgEQCA7zqNZb2zcLEehe6OLURuuJzKwm5vsI3UsLaxsK
         ZT5Q==
X-Gm-Message-State: AOJu0Yzl7vLQ9bHV4cur8QYHBqRWpe/EEr8mNV+ZlAGJPzh/dVz8AdyA
	gZRERtVZCYSd4rXnY4YleLdr9VCdlfTgrmC+oWm6JQ0F1PlDlpODiMTsVC9nWt4ka/BOZveE/K6
	amabd
X-Gm-Gg: AZuq6aJvcSxnslq5vt3rME2kgurMG6qxJXbsIWkYp0ytr9ye2ZqolYj5TOKtiP/ezQI
	3nN9CWW8kVXNjXZocyTN/bHEeWAHgF6do+CEjp+W5kgCRVbU2qPJ2NoBbX6OaE57mNKOBEJnmhK
	NA9TgvN2SVgAN9pEGMZ61yUiQfa2F7VU7WcGLzRE36/j2/48QukPUrvl1xzt+oSVfbN/k0IiPUc
	dYz1ZWKb0lDHhToj9t9IJbXAOf99mm2HVpIwrBnV2p7tcyJ7OabGCYaQHDZDKNvXmTM0LbeQdHW
	WCVf+enuBOyKg0BSHuaS52jlomrP9yEjzSd5WQ5cfITWLyH05+BLnZ50gviCJdwJ/UfmbosVmuu
	IpjagU/EE58Lc8UO6BdbdaYX8fshkT2GRzU/70H5JEig27ziNuJHyIdjof90JOz4tn9EXCmJmos
	UXZgW3UYy9sVgfHuCA
X-Received: by 2002:a05:6000:25c6:b0:42f:b707:56e6 with SMTP id ffacd0b85a97d-43629378429mr2660907f8f.34.1770365848816;
        Fri, 06 Feb 2026 00:17:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd1c9sm3892216f8f.15.2026.02.06.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:17:28 -0800 (PST)
Date: Fri, 6 Feb 2026 11:17:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kalle Valo <kalle.valo@nokia.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wl12xx: add driver
Message-ID: <aYWjlcQDj4YsoGlt@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31616-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 6003FFB5B9
X-Rspamd-Action: no action

Hello Kalle Valo,

Commit 2f01a1f58889 ("wl12xx: add driver") from Apr 29, 2009
(linux-next), leads to the following Smatch static checker warning:

	drivers/net/wireless/ti/wl1251/cmd.c:247 wl1251_cmd_join()
	index hardmax out of bounds 'bssid[i]' size=4 max='5' rl='0-5'

drivers/net/wireless/ti/wl1251/cmd.c
    229 int wl1251_cmd_join(struct wl1251 *wl, u8 bss_type, u8 channel,
    230                     u16 beacon_interval, u8 dtim_interval)
    231 {
    232         struct cmd_join *join;
    233         int ret, i;
    234         u8 *bssid;
    235 
    236         join = kzalloc(sizeof(*join), GFP_KERNEL);
    237         if (!join)
    238                 return -ENOMEM;
    239 
    240         wl1251_debug(DEBUG_CMD, "cmd join%s ch %d %d/%d",
    241                      bss_type == BSS_TYPE_IBSS ? " ibss" : "",
    242                      channel, beacon_interval, dtim_interval);
    243 
    244         /* Reverse order BSSID */
    245         bssid = (u8 *) &join->bssid_lsb;
    246         for (i = 0; i < ETH_ALEN; i++)
--> 247                 bssid[i] = wl->bssid[ETH_ALEN - i - 1];

This is fine, but it should use a struct_group() or the KSan stuff
will complain.

    248 
    249         join->rx_config_options = wl->rx_config;
    250         join->rx_filter_options = wl->rx_filter;
    251 
    252         join->basic_rate_set = RATE_MASK_1MBPS | RATE_MASK_2MBPS |
    253                 RATE_MASK_5_5MBPS | RATE_MASK_11MBPS;

regards,
dan carpenter

