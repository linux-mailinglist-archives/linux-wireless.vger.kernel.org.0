Return-Path: <linux-wireless+bounces-18904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6BA3396C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AA51614A6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140C207DF0;
	Thu, 13 Feb 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8qkgcpJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A8204C1E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433624; cv=none; b=YoTTKOvSiyhpsP28Y4TWboNE4ajAeYnlqeTVSVDpltucN1Ga6taw5x2Ey2fWUPppuZmn8kFtxq3FKnF2tGf72xtU3LFC2+Tpb0oWfggWkS1Vqv/DsFu22oEqDcbE2J4oAECIFNy8YsbJYm7NjyLqWeXR3LnyV8/o6nmyUIgTq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433624; c=relaxed/simple;
	bh=haTfWRvPPfg95+pmW8xhhapMdFaDBGcdyJa5CjvQP3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rjQbneowgQpscwNKxb4Nv2hwJSerfciGDdQf9yoaXcPGyiKmbaSm2WzNiBhzGgSsJ7GEQ6Ie5nQukUKh3B1oU0C+JQi9Vr31Jb0FreEcWLMs1LUc4V7MEDkXyhDPsjxSoGAvDtXUapun+Lr1uKWosxJBge6mREFVcdRr0xhciBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8qkgcpJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so959369a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 00:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739433621; x=1740038421; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Ty52e1WASFNgSLw3eYvPpwBZpTI+wQtoXQ6iwhUpY=;
        b=D8qkgcpJJzaSQt/N/y0z15/mx8M64MH5mNOgtVSLabP+9jAlJ4DjxfkJQ0F4jjzgnL
         gtQe92/Ey2mfvxHDFARYe548ICcvAKFhv6Wf0B1z8GYUHtmJs5PmcNHOdpRceK4f6GRo
         mTJ0XTgQYXrdWBVgEPrm73LPg78o8GNxVCzZUGZl82sxouxRNQxVW26zQsQhxIPrmuUi
         Ets55f01pgxDuw3NomBxqEJRltb4yoakOeLrqv5z3w/SNJDmqILujroLPg3emknbRlUT
         6F6GpPVuliAr21g0idCxqGwb2JkCbc401nJxUg65ruOlQ03Rge6iHjFHkSSTO+ZBSi1K
         WwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433621; x=1740038421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66Ty52e1WASFNgSLw3eYvPpwBZpTI+wQtoXQ6iwhUpY=;
        b=QryknFf1M+OKsSNWuP0urrM5lhJfOCG367kqxcqW1XEcAHxdNeyy2wGNNUGHuvpz0t
         4ztSTnbEGBwqecWXtSXb3jNRCPEOSVv5utHUtywOcWNdmoH8woz0/Hpy5Uo5v/x1oPi0
         xRds0efPa95I4W72uEN953cyDha8+G+Gr93+2tXO7c/7vDkRuW0XLjCfK7H7bZP9nBF3
         r8+hm+quIH5DeDo6TIHBc2G19VIpHggR8xxvQGi/S4P2viof2psfQhp9tqCELheXx7+i
         CE2cN7oz2iqmmCA2luPqn+74fgyKUh9NZfNi+4DJEM0tmVZd43e4nP0rz/sfkSejhgW5
         0QUw==
X-Gm-Message-State: AOJu0YwkiSzqj9k13PhF7w9vGBMfSc9zHtRKbr3yjIGInOGnW5sKTFH7
	uzbVgXCCwxBqtIBN43DVJtmnkH7duM7CwL9oBZDXBVNmWhxA4WA3gF9zpCm9UydGi+zetadoYM+
	q
X-Gm-Gg: ASbGncukkmsCpGpW+1CydOf4WxPraGLGK4qJnHYxZeqINR/GZxJxwdYwMoeMBgZ7/Vu
	XWe2beOTdi3/Dpzdvn/jZtf5SpguTVrZRgvhQGPBpiOc8RwVM57CtDkqii1o49empO8SJthS82z
	M8xkMFekc7UwONWqsUffz/jxrF5HnMecy2qat2S+pWwKku0prt/TNmev/M2ZoGVVxGb5ppGfIGe
	QFF54krrwEGNAihkSLGzGd8TIGKq2aEuNJot2VWX+Qqsiu9t4zNzIovTvv3PesQdt3eRp5a+rDN
	StIA99O2MhICTsMoYsBp
X-Google-Smtp-Source: AGHT+IEAERJy3MTU4qmYASPb6Cs2M0Cg02kvwTuLDwyMRhERCZJA7iellWuQd5pYQR+bCV0xL82TXg==
X-Received: by 2002:a05:6402:4409:b0:5dc:89e0:8eb3 with SMTP id 4fb4d7f45d1cf-5deb08810a7mr4425312a12.11.1739433620716;
        Thu, 13 Feb 2025 00:00:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece270feasm732060a12.63.2025.02.13.00.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 00:00:20 -0800 (PST)
Date: Thu, 13 Feb 2025 11:00:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilan Peer <ilan.peer@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mac80211: Add support for EPCS configuration
Message-ID: <1f7d9499-5183-4d4c-81f6-dd43899d6746@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ilan Peer,

Commit de86c5f60839 ("wifi: mac80211: Add support for EPCS
configuration") from Feb 5, 2025 (linux-next), leads to the following
Smatch static checker warning:

	net/mac80211/mlme.c:10707 ieee80211_ml_epcs()
	warn: error code type promoted to positive: 'len'

net/mac80211/mlme.c
    10663 static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
    10664                               struct ieee802_11_elems *elems)
    10665 {
    10666         const struct element *sub;
    10667         size_t scratch_len = elems->ml_epcs_len;
    10668         u8 *scratch __free(kfree) = kzalloc(scratch_len, GFP_KERNEL);
    10669 
    10670         lockdep_assert_wiphy(sdata->local->hw.wiphy);
    10671 
    10672         if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_epcs)
    10673                 return;
    10674 
    10675         if (WARN_ON(!scratch))
    10676                 return;
    10677 
    10678         /* Directly parse the sub elements as the common information doesn't
    10679          * hold any useful information.
    10680          */
    10681         for_each_mle_subelement(sub, (const u8 *)elems->ml_epcs,
    10682                                 elems->ml_epcs_len) {
    10683                 struct ieee80211_link_data *link;
    10684                 struct ieee802_11_elems *link_elems __free(kfree);
    10685                 u8 *pos = (void *)sub->data;
    10686                 u16 control;
    10687                 ssize_t len;
    10688                 u8 link_id;
    10689 
    10690                 if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
    10691                         continue;
    10692 
    10693                 if (sub->datalen < sizeof(control))
    10694                         break;
    10695 
    10696                 control = get_unaligned_le16(pos);
    10697                 link_id = control & IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID;
    10698 
    10699                 link = sdata_dereference(sdata->link[link_id], sdata);
    10700                 if (!link)
    10701                         continue;
    10702 
    10703                 len = cfg80211_defragment_element(sub, (u8 *)elems->ml_epcs,
    10704                                                   elems->ml_epcs_len,
    10705                                                   scratch, scratch_len,
    10706                                                   IEEE80211_MLE_SUBELEM_FRAGMENT);
--> 10707                 if (len < sizeof(control))

If cfg80211_defragment_element() returns a negative error code then
because of type promotion, the error codes are cast to size_t and become
high positive values.  They are treated as success.

It would be easy enough to say:

		if (len < (ssize_t)sizeof(control))
			continue;

But I really am not sure the continues in this loop are correct.
Shouldn't we instead bail out and return at the first sign of corrupt
data?

    10708                         continue;
    10709 
    10710                 pos = scratch + sizeof(control);
    10711                 len -= sizeof(control);
    10712 
    10713                 link_elems = ieee802_11_parse_elems(pos, len, false, NULL);
    10714                 if (!link_elems)
    10715                         continue;
    10716 
    10717                 if (ieee80211_sta_wmm_params(sdata->local, link,
    10718                                              link_elems->wmm_param,
    10719                                              link_elems->wmm_param_len,
    10720                                              link_elems->mu_edca_param_set))
    10721                         ieee80211_link_info_change_notify(sdata, link,
    10722                                                           BSS_CHANGED_QOS);
    10723         }
    10724 }

regards,
dan carpenter

