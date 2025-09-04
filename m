Return-Path: <linux-wireless+bounces-27011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B1B43CD4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C821C27346
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD715A85A;
	Thu,  4 Sep 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="fZ9Cul89"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825060DCF
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991790; cv=none; b=UqjO6jMZ+P+ZdgXmU31FIPQWwLA+Y1UKUiOOAWlYqPQmBo7wrwF5aEDANZeQ8q9ro2cZPY5EVerIaD6Yjyu9Od8GMvI+WkhPWdwTn9cEkOlu1bzOjCPqMFM1llJKHSQFEDf+HbPgVxE6NkwUCRc5V2/lMqBlcPP21rCVBv4VXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991790; c=relaxed/simple;
	bh=eBbjv+Ue6A7jDZqQr561jxgX2GaCn7d0gPiNHFVoc4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdx/mtJCqhGujWiH0GwpMDmxXjeU9Qk68vKufhek2+cW+RuZdQV9VItmhAUzhdlWcslYCB11QP4XB5F8ARRrf5pMegCTLNKrn41+cdhgk7pQ+E7qyj9Csbh65CnX9q51m1moABFH6HvFYjICf67sO20YKhJFiHrNt8QT3wWE0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=fZ9Cul89; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b21006804so10466405ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756991788; x=1757596588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2MqpGy+5EV7F7+smJIBR5OoRhfWl+67+naN9I9865A=;
        b=fZ9Cul89YXX+FXLcUkCajDGXzWdkVUtTXgNs35kReEa1LAF5+QgsIIFA+J++k+m4Xa
         Oy7z5LRRdx/nqTXCPf6zUoOurO+8BkrfvfZzp5tSNNvxeo+26ZZ2R9hS5qbtxY3guvDB
         wyauNbDdO3Or31VVWUvwq75JvxL9nom4iOjJFUovXybNfw76sMDaN0KDi403CGM4Ys7W
         vWAiMHJvFuv+kNEYwoX9aDbhXcO80QHs6qaMXUsckjJ5pVXh4RXw6GnrfqGgTCDmZj6i
         lB/c6hHLcCUrSehhvJVjlWLAIJ+l4OlKaieLd2T5SYx7pNgxihQkheHBULGr4Sy+VdVq
         Gf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991788; x=1757596588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2MqpGy+5EV7F7+smJIBR5OoRhfWl+67+naN9I9865A=;
        b=qsS+iFrhWhqWV0sayrsPNgkGaleL1fdwM5dEpba+Grp3x3UgCNuAy33pyyztlt+7Fa
         w7d1dcBkhIvThWtKvu0XSOGpj9E8rDcWMSMsI5CflM7LNjJcLvyGZVinEKF2Kw0Jb8XV
         1u7OpYAKzHdNyr+Xn5SssnEsK6T7w2NmrQqeivw4bM0KBJDdc/KjpYYhiO4xHlyjQunb
         IWtIa4pDa6WWiMay6z+RQGRAgT9+oh6ROHBIbPay5xrbT2V1MkizLgpp/xNzCF+fCZMg
         ORwjrx6ajh3fcKBNklknvMw7krGYBQkzM3GOTmvHi/7OnuxWKMscZsOlkRSRogd2hVyX
         GuLQ==
X-Gm-Message-State: AOJu0Yz+xUJNg2SOim4o7SfRSzZGqwY6FktBKvw0veJAkQSHYCHmwhPl
	g88jhzegTIlU/rVroyxTVYVuSNV/dc9eavQhosMKTW5xAUXOGBq21miXyvZXq07PZvL8Ty0kCLQ
	p6UUk
X-Gm-Gg: ASbGncud5rOg3vShM0wG+0RO6cShrDoftxPBxHhA7CT2yDf8PGrcrMo6tsnj4NIJ09K
	tufqD+jGxS0ygerUFH0pRzd11N2qtubXkiWmnVPa+dbh7M0HJZQUY4ODRU59RF68jDIOi2GwPMk
	Kts04iRZbJRe2ghf60BXwb85NA4JGdBraKB+Ui/gl5JUfYgZlj+KaYuyV385T6FrJDprOcg+xxa
	99XMEr1bRayqrIXliKdza98sLr2cm2/klHBDKA9nlIFLZz5Ci5YkeK/MD6Nav2WSxlNiZjt/OFM
	xvf/1YRszRaPHf6sLMBdXo1YYyF9uRCk5xxH0XHGKnjp8J936TgPoHR6TviVCtmNZXuE4M/KbBt
	78msZNkrqMGA0Aw1LOL9xf682EkQcx5/Fougr2nh4mylnjTW9TAAhlUkYQOdmo3oV
X-Google-Smtp-Source: AGHT+IH5Uyzlt1B3WKaBmNCG+TArB/D9HStJpzhNRMNzKEIkUMwh1jV9rkicy+XgVgh6BJQY4Jr4zA==
X-Received: by 2002:a17:903:4b46:b0:240:48f4:40f7 with SMTP id d9443c01a7336-24944b29c03mr280173815ad.39.1756991787944;
        Thu, 04 Sep 2025 06:16:27 -0700 (PDT)
Received: from localhost ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329b4ef032asm11477437a91.13.2025.09.04.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:16:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 23:16:23 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
Message-ID: <tlup37v4evpkipsybp4ooc77bonpxwm6yxjrky5gosqza5mrkc@bkqv4hl27c4v>
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
 <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
 <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc>
 <78645f03a5b61371ee9f95544695ffe86bd1ed8e.camel@sipsolutions.net>
 <7zj6xu6apxs2b73iwsck3p5qappcpt3hn7vrdecvfh3to5ixzw@3uzofpejtuvu>
 <298c43de5b668ea9b9996e3ec0547007f6e65174.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298c43de5b668ea9b9996e3ec0547007f6e65174.camel@sipsolutions.net>

On Thu, Sep 04, 2025 at 11:02:46AM +0200, Johannes Berg wrote:
> On Thu, 2025-09-04 at 18:59 +1000, Lachlan Hodges wrote:
> > > 
> > > Did you want to do that? As I said, I can also just fix it up, but maybe
> > > you also had other changes in mind.
> > 
> > I reviewed it last week and was happy, so if you want to make the fix when
> > you apply I am fine with that (and saves me a bit of time aswell :)).
> 
> Will do!

Much appreciated for making those fixes when you applied :).

lachlan

