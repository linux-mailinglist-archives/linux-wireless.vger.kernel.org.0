Return-Path: <linux-wireless+bounces-29077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F280C67C57
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 07:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B716329FF8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4252F12A1;
	Tue, 18 Nov 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4EXfk9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D92F0673
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448399; cv=none; b=skeI45O332LmbI8HWrLPQgpg3kRSHLrsZimCAMd0w2CubKaESAnLQp/mLJF+svEd0PV+6x5jBjWaoPcMLO+if30tx9PsALf6uZapx/33Pi0GdVpAgc+KboK/5G2TalOGp5rzvwrJLk/HptJMIIC8Fhf7rHjE2lUTfW4S/GBGYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448399; c=relaxed/simple;
	bh=acujsx5P9AhRcG+rLz3vEfDBti6lUvFh4LWYV3tGlm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm9VpJGmET6MH20D2VJft+h6EYEn+aZk1JdPsvZzMF78tr1QWGmyRQjT0VayJQThYSGjBb1X8Yi1PYPMPlLo/c7rpclJpNfN3xeAvD5a/35pILEZE+euZWi5UDgE46MPCTonbsO4b0FZ7p2+cdHfbjMHp55VDb2CQsECA3RTGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o4EXfk9N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so36053695e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763448396; x=1764053196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bV81dIpmp2beeLjKl6yrCue5z+eyzcey/0i+ySpQ3bY=;
        b=o4EXfk9N0TzPjImeauhSC7o07RtfBQLBgPaXzRU9jzye9/Z5UF8NDgW+bpHkfgvRzG
         OX6podmX7/zDTEDuupHrMynWdvOpiODQUvEZYQ4jtVHqW7cJ2nXUOqC0Jn/0gffcdJk5
         D00q8jULEUetcIwA+m/EJ60C8YEbkyy5fd3n/Mg1+Bxo7YL5GqgVFEEDu/HzTRJLZRJg
         iQCKztVaavWTvT03DMjphosMXhE/CPsN8WbmHKHdO1lF0VDEdgw7ASH1uvsqd8gakHRo
         JVytF+OWdkUn5opfRcAFKs7FdKvX5G5OXi5uELSWBj1QhpVCMZxU1sqSOFkQdiwWtxYN
         2kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763448396; x=1764053196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV81dIpmp2beeLjKl6yrCue5z+eyzcey/0i+ySpQ3bY=;
        b=XsKyN8PjFQD8kMwJwVibf2zvSev6ZFk09mEcf08OEQ2tpd7JRMtXhGmntj+L9SkgyI
         6sG7Pityv7XItw2OQdGk1bIcyaOPdh5QyMJi4BODZh2labCq0FZRQoRJjhutA28fkm60
         lSLSIn1XR3orJvInrQL0+s0cOq577oep1QNwoqP4HILnN2rRpTtPnj0DCFSrbq4gS4dZ
         +4+5hB61jZMeEjU7bxry0PYQShRvjlLEhcjzboD2YXz8I0yF7Tu5cyZ1H+8YovkxFqT9
         cDww3vjFtdnaplqTCYWh2kkhBwauzZRDkdhwiAzkLBANiRrFuF9Dd+wZ9pQV7xvVrHrC
         82Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXJCvDQKxPNy4hxAEthmc7O4Z2UZQomt6mEHlA8KzemfL82FxyfB2ejIWB7H42BH6LDo1YnYlzLGRR6jpmPWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3LNlJ4PAxFA+ixDc0T494daqg3dsYbK/wvUWbYr26zNy7L1X
	dJVMQ5R2WKlBU1QH4fNou0hgEaE6pdMMhlIPAUGXkPNfGTYaNgbpKRVxXZciW2hJPdY=
X-Gm-Gg: ASbGnct/FYqxynkEKeTcydNWe3FXEunqTS3sBzTFhhUSF2qaGhqDdUfvFit8FtAsc9t
	cF3idokdQe7oIPS5kglIOml+fbeBl/Mmwzu7VfvjNFQBKGlbt2fHBtpzMx0KZ/8K8wEJfLS5491
	B3s4M/sN8Jzw2jYd0CUURpQe41TdbHcQA9RQpl/8cl9AST5P1LzTuhpA5BHzlY27DOXS4sjpdh+
	132qYviZ4HX8NRstb4Y1MvEOThpTRkCd+bzL+oquzDcY6RRMwbJ/amDe2o26yt2BORUjTH1Hz3y
	HwdBh5Ykfo1M5U6s3k4l59AZHNBU0vTmgRhYEPd1OjinuStX1HHN2zlJLKaEbRJc205CR39BMkH
	rOGYFH5PlHcJLQBRCEY/vMf53/ZLK5ZT+1dT2DwfuAyxWdojftHSlc/JsxPS2PDG275ueoLmUVz
	XuLjOHqw==
X-Google-Smtp-Source: AGHT+IHq6Tms2Tw4FCmoIgazMAaNdHCOZjsBWCUnSI/7xQlYbP/8sN+ivg/uC6ukSMsCFy3UUZ450Q==
X-Received: by 2002:a05:600c:4744:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4778fe6be5fmr138575145e9.18.1763448395731;
        Mon, 17 Nov 2025 22:46:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477a9e19875sm8557925e9.16.2025.11.17.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 22:46:35 -0800 (PST)
Date: Tue, 18 Nov 2025 09:46:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Ally Heev <allyheev@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: wireless: fix uninitialized pointers with free
 attribute
Message-ID: <aRwWRmOfO5URjacJ@stanley.mountain>
References: <20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com>
 <DM3PPF63A6024A9B5D5C1983918C785DA13A3CEA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A9B5D5C1983918C785DA13A3CEA@DM3PPF63A6024A9.namprd11.prod.outlook.com>

On Mon, Nov 10, 2025 at 01:17:10PM +0000, Korenblit, Miriam Rachel wrote:
> > Subject: [PATCH v2] net: wireless: fix uninitialized pointers with free attribute
> 
> Please send iwlwifi patches to either iwlwifi-next or iwlwifi-fixes ([PATCH iwlwifi-next] wifi: iwlwifi: blah blah )
> In your case it is not really fixing any bug, since we never return from the functions without initializing the pointers.

I'm not a fan of these subsystem rules.  If you're working over the entire
kernel then you would have to track over 400 different trees.  This could
easily be done in the one place on the recieving end in the QC process
instead of forcing every contributor to write little shell scripts.

Anyway here is the code how I handle that for netdev.  For BPF, which is the
only other subsystem with this rule, I only send bug reports instead of
patches because I really want to discourage this kind of rule...

git remote update net
git remote update net-next

if grep -q netdev $MAIL_FILE && ! grep -q wireless $MAIL_FILE ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if git merge-base --is-ancestor $FIXES_COMMIT net/main ; then
            TREE="net"
        elif git merge-base --is-ancestor $FIXES_COMMIT net-next/main ; then
            TREE="net-next"
        else
            TREE="net-other"
        fi
    else
        TREE="net-next"
    fi
fi

So the new iwlwifi code would be (free handed in my email client).
First add iwlwifi as a remote to your developement tree.

git remote add iwlwifi https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git

git remote update iwlwifi

if grep -q -w /iwlwifi/ $MAIL_FILE ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if git merge-base --is-ancestor $FIXES_COMMIT iwlwifi/fixes ; then
            TREE="iwlwifi"
        elif git merge-base --is-ancestor $FIXES_COMMIT iwlwifi/next ; then
            TREE="iwlwifi-next"
        else
            TREE="iwlwifi-other"
        fi
    else
        TREE="iwlwifi-next"
    fi
fi

regards,
dan carpenter

