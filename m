Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210B2A710D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgKDXSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 18:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgKDXSm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 18:18:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72510C0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 15:18:42 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t14so170225pgg.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 15:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVXyafJOk5lpIxOr4DjhZSZeXG9pxT061aUHHfnedeI=;
        b=Fjcus7uN2fwKtsBsDnm5domkmUu8SrDvZr9FsqcmQfTmNVzqdP8uPtkv1Rvo5FuU9A
         ErnIy+m9P5rbd0JsFelPBGJOIE2ZgvvHb31MKWYYFM7Atom2Nd/SSaMfAsHGyissoDYy
         9MTWj7ZmcV9W73iIhApWEOTKprghlY7+zU80Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVXyafJOk5lpIxOr4DjhZSZeXG9pxT061aUHHfnedeI=;
        b=iIV1oSJM5C6l5S4WRRWKy3Y/26Y6GwMW9AlyY7ZCPJSQHIFXDi9JqEZkIZZTG+Ulkv
         fHNOk5hpgzLVAEHGvPh8oPj9j3flIGlcHESjG+nbm4/vgMYCndSHIn7W1HM4Q9AOuSFB
         sIC1rBG+6CuKRPk4VkF83/5Ry0pwYyKd8MTnKaubKr2vc/ObqeQH21YdEQMN2krXwXVD
         lzDbaXz9SFVB/pgh69LUurw0iQj88h7I6TzDUO9ZEq6m3iRtN1z0+AmSwQ5cgYZcrF83
         Id0v8VrooqY3mEqM/1CqkR9pLxkydWKYQ/Z14PVYf6AOrL94skP2qEDJbTO+aS3ViYx8
         iHbw==
X-Gm-Message-State: AOAM533al602rBpPcS5x5XuQdfjSRY9lBJcs4QPqprUwsVeaUpIFq8ca
        TpI6Okwn/QL5MLrgBRrgVTpQJcGVVpCIzA==
X-Google-Smtp-Source: ABdhPJyoy7F19wDdDWigpGEabbcVOhP4TB3CRLdKHIs5AncRGVmG6f/V+B3vN18MojMEJ4CaPtMZ9A==
X-Received: by 2002:a17:90a:4215:: with SMTP id o21mr241056pjg.166.1604531921609;
        Wed, 04 Nov 2020 15:18:41 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id d22sm2972985pgv.87.2020.11.04.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:18:40 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:18:38 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, dianders@chromium.org,
        kuabhs@google.com
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
Message-ID: <20201104231838.GB3212577@google.com>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 28, 2020 at 02:36:09PM +0200, Johannes Berg wrote:
> > +#define NUM_MAX_NL80211_SAR_FREQ_RANGES 0xfe
> 
> but I'm not sure what these are used for in the first place, they seem
> more like internal implementation details?

I think the MAX value does have some utility in the API -- as mentioned
in other comments, if we're requiring that user space must SET all
ranges at the same time, then we need an expected way for user space to
SET a "don't care" or "MAX" or "null" value for a band. So if there's
some new band (e.g., 6 GHz?) that user space was not previously aware
of, it will know to use this placeholder.

I think that's kind of approximately what the purpose of this was? It's
not super clear in the documentation, so maybe that should be clarified
in writing in v2.

Brian
