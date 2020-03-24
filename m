Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2261D1918ED
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXSYC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 14:24:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXSYB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 14:24:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so8488264qkj.13
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5HUKOqQVNvJBeQ6DbOjWevVuL/Wzu5kFmR+gJYZiY3A=;
        b=V1DUcgYYuNvOGRzjR9lySeV97MksL6bfv9XA2JHurQjkTcWPDkCbuT0sOAcmlx/ohF
         Tr3kJg9lF4JAzgLXoXfYY6nKIT963E1psu0u7EXliqZhfC6F/WATeowq/gzAty18b+Qd
         1tJ6VU02PLFNmyZRMDBSM0Yu2OTOWmckjSCh7cs6F0ZgoMzdXjXNLjPwZOGTg/VSKutY
         ygWgvuD1xL4czvezdazGquen/BdWNFjX/heyg+STdlpCUeiUbLBUD4ZIaWTXzhAMmKtD
         SqWI3GWIc8fe8zJ7cPksMQ8uUeUpW4klw39yftoT1suFb4j9Q+43xqQ8t9t/8DMkXuZz
         TuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5HUKOqQVNvJBeQ6DbOjWevVuL/Wzu5kFmR+gJYZiY3A=;
        b=r/Ed1/YcOGL3FDTRBAsE7RfsVNPHeh/oon2fGHcE5eTUJJoNjOcBTWdMcrYe6aeUCG
         cGI5FU5fVB7jP6Pm8addPb8DNf+yef7b0i15sPybV/ex4S0181a7BV17tUwHG+9lw0tO
         262003H0jZG06/dxWWt3o1QuyzTPYEXi+eOy4YBDE7Cp36+i07K7lk0T6zfDJ4HnlA2T
         2iXJlmnIj045C2sh2AejPepf3px3Y91sykCeZSKMhloEXpdqBxjFnvWG/r6luL4Er+Re
         IEppjf5LRJr4ca0GTh1RIj0DNWJvYUd5JojRS1+ifcLLlyW4hOp0pHF7zG0MvZ2vQmAc
         0T3A==
X-Gm-Message-State: ANhLgQ0JzehH94F5KseZp3+ijojFAqs0eznyh63FqETUZiti48Pk+vdI
        ZvNaRFtir8dPTTd9NR6juJ8=
X-Google-Smtp-Source: ADFU+vtJ3jfbe8cL/K79dzbjwsejVD8L5MtVuCOmNgRwcKnYQuoeLQ5y1VZPAlvYYuXuXq5nwHbgMg==
X-Received: by 2002:a37:6ca:: with SMTP id 193mr27724087qkg.415.1585074240548;
        Tue, 24 Mar 2020 11:24:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id y5sm14010562qkb.123.2020.03.24.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:24:00 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:23:58 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
Message-ID: <20200324182358.GD162390@mtj.duckdns.org>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On Fri, Mar 20, 2020 at 04:08:47PM +0800, Wright Feng wrote:
> > So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use
> > allow_workqueue basically dropping __WQ_ORDERED. Not sure which one
> > contributes to the behavior described in the commit message.
> 
> The combination of Unbound and max_active==1 implies ordered, so I suppose
> we don't need to set __WQ_ORDERED bit in flags.

It doesn't on NUMA setups. If you need ordered execution, you need the flag.

Thanks.

-- 
tejun
