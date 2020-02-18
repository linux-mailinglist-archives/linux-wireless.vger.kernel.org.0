Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BBC1623C5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRJp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 04:45:28 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42780 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgBRJp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 04:45:28 -0500
Received: by mail-wr1-f48.google.com with SMTP id k11so23039503wrd.9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2020 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oyWcNkzDiOugjZzlaFVEa69JQBxRsP6uN5Q+Idpuqjk=;
        b=MwBzLKos/zmYdhCm2y7fHjK2oFr3W8MpHpHKNO7z+wfMyKnnxC+gE45LMLAZTnHox1
         wquGA9IdAy8PFAC88OaOsKerC8rFeH7vrDYSRb9M3YJE1n40owoX5/rDuGcB152ZA/y4
         oqL+0YfwZpFT6EPTHEBCKEDTpHcbT6eQb3dEZaLXnce3N396O1TYuamFp1puL8sRe93a
         KwfzsDOGXaLr7Z+mWiXQ8Nrg3cJqn8vPIByXJe3qxlRgPUpPO5csVxssJKcrAAwTsYtf
         EyJhSyLFqrMZ53D7mASzLPetSVY2sueGi+kdYwNySZGS+KkjQ7jv20PgIEbs9RmUf5pN
         i0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oyWcNkzDiOugjZzlaFVEa69JQBxRsP6uN5Q+Idpuqjk=;
        b=E6LveKD+drommlsSLwnaKTYcu02/FKpdfWntLlCdaYTqlkYeF6+aN2ss5jdZVAdbiI
         fGyNv+V2bm5CJWqNbsFeVYbjKgDzRmjVcjNup4lo8Xx3W3nhky9SFVk7t3g12f6dKwK+
         my2YWPQ4TkhoJUzREJnhyHWVQQLsLkLgz5EfyDPUTEOlM4iMPe0lSru2HqIAXh7WgE1m
         e3rd3Eof39tMnaFFM7lo82S+B9ZApm+uk+ogMBPqQXwSegKOdQiwWO4lpQWw1ecWXTS8
         3i9YjFMCf+haNFClQ32nL3obKNWUXEAE76+r7Hn6am9k4BRRGb7rBVRme4ZdErjbxP8r
         dvkg==
X-Gm-Message-State: APjAAAWjTOwbM466jwNPlzjq/MP7Rw0jbmhQhyFg+IFaDqqxjbeRuuQO
        +2V5gZx7Ws1M/NJfFAhBPXw=
X-Google-Smtp-Source: APXvYqwhsw4NDbuqBIW3qW+ks5jbNOU7XAV71lNkO9ph8Lk6EMFDEde+y9x3cwk+3QsMnsQsGpDaaA==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr26430870wrq.98.1582019126540;
        Tue, 18 Feb 2020 01:45:26 -0800 (PST)
Received: from t2b3 ([109.175.105.6])
        by smtp.gmail.com with ESMTPSA id m3sm4983168wrs.53.2020.02.18.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:45:25 -0800 (PST)
Date:   Tue, 18 Feb 2020 10:45:14 +0100
From:   Tobias Predel <tobias.predel@gmail.com>
To:     Bjoern Franke <bjo@schafweide.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
Message-ID: <20200218094514.GA13937@t2b3>
References: <20200214214134.GA12764@t2b3>
 <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
 <028ea5d3-1459-b37e-f996-72958be0ff4c@lwfinger.net>
 <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I withdraw my issue. Linux-next has been working well so far.

Regards
Tobias

On Sun, Feb 16, 2020 at 02:40:17PM +0100, Bjoern Franke wrote:
> Hi Larry,
> 
> > I deliberately stay behind the official kernel repo so as to avoid implementing
> > any regressions. As you are the one with the problem, you need to perform a
> > bisection to discover which change to rtw88 introduces your difficulty!!
> 
> Somebody commented the DKMS-package for your rtw88-branch with
> 
> "Thank you so much for this ! After kernel 5.5, that's the only way i can
> get functional wifi on my machine. (RTL8822BE) Deeply appreciate it."
> 
> So I assume I'm not the only one experiencing this issue.
> 
> But I can do a bisect if I find some time.
> 
> Regards
> Bjoern
> 
> [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
