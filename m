Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFC54C2D1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jun 2022 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbiFOHqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jun 2022 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiFOHqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jun 2022 03:46:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6883403E4
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 00:46:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e24so10558139pjt.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=97ZbqaSbTNVXJBqPnuU/MXd5+wf64Gfrw6GMlVSmi5k=;
        b=ku5wJ6MwLVP3IC0ul/Tq7w4jF4ulDdQn5+9RPjRQ/CXpaArVWvfnPCj5GwLwAfO4ea
         o4oNqRrbIjJinPcQwNZptKHwbFjKspJ95ufIpYKHufz1b9eBc3YhHksYuGx+62vIXrHy
         FKpPJXcj9i9ZOEcvQjV5ZTmMYvveySDz7g8if8pRVdnRFicvLPyC9ku1BRVX86qgk/8s
         UGDqc9hUBuMFuOT0Ft1DNeK31uTthNv7boViLFWGLnhL1zxHeI1rnrbVYJYjPIrPN+Cy
         yypQwN5BoCVDvPLWuIQSgfhil0YPLrwcSAWP92z6fzaIbTyoNWidDFEZ9bluaneGVbFA
         bNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=97ZbqaSbTNVXJBqPnuU/MXd5+wf64Gfrw6GMlVSmi5k=;
        b=gfp+dxpEDEvwIl4emfRudcZwC+GfdWSveIfCZ26zKTx/u0jWg7OguyAfRK0KcdH8h/
         YLIBconL6RWX7h/PIpH9f+3C0ALK3KllfPxcnNBQo4Tbj3gdGHivXrch1OkBD5fJFI5K
         461KL150a+xow29g530Wh1mEaWKHs/FLEM+x1LNyGfmldCnEdn/HI9W4Xjd7E1W9w5t6
         gtrLzZy/Tlp8OyQjfVyEcKwquneM7azCK4xvYa6CbWRu8m7hJgMnxHjLZwPuYt10dcg9
         USMdCZ7zqzjLrUQ6ejnbiGGnCKd4yHqXn2kBGDUNH70g36hJvg95bzymqRjA7sJbkz9w
         crwQ==
X-Gm-Message-State: AJIora/f2r62NCvUksLOwhg1CEPrXye/ROB/1C7SGXCtxpYdG9vwgHlz
        gn/su3H0Ou753zqMJtY3F18=
X-Google-Smtp-Source: AGRyM1tHhQLYdLD17FyJ5iK13YLpINfl1ov52bQsmIAhf05vTzh8lvqa5u/akJBG7mRtszNPQGCY1w==
X-Received: by 2002:a17:902:76c1:b0:167:6ef7:dab4 with SMTP id j1-20020a17090276c100b001676ef7dab4mr8160546plt.146.1655279161174;
        Wed, 15 Jun 2022 00:46:01 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id s19-20020a056a00195300b00517de3dc3c6sm9094309pfk.84.2022.06.15.00.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:46:00 -0700 (PDT)
Date:   Wed, 15 Jun 2022 00:45:56 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: pcie: Fixed integer overflow in
 iwl_write_to_user_buf
Message-ID: <20220615074556.GA597096@ubuntu>
References: <20220614173352.GA588327@ubuntu>
 <fe88188dfe37050b097803a4ce175478a794208c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe88188dfe37050b097803a4ce175478a794208c.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 15, 2022 at 09:06:51AM +0200, Johannes Berg wrote:
> On Tue, 2022-06-14 at 10:33 -0700, Hyunwoo Kim wrote:
> > An integer overflow occurs in the iwl_write_to_user_buf() function,
> >    which is called by the iwl_dbgfs_monitor_data_read() function.
> > 
> 
> Out of curiosity, how did you find this?

I found it while analyzing several device drivers as a personal hobby.


I also want to ask you one question.
While analyzing several device drivers, I found several such integer overflow 
or race condition problems, and made and submitted a patch.

https://marc.info/?l=linux-fbdev&m=165497564701256&w=2
https://www.spinics.net/lists/linux-efi/msg24884.html

However, there is no response whether this patch has been accepted or rejected. 
In this case, do I have to send an email to the higher level maintainer? Or do I have to wait?

Thanks,
Hyunwoo Kim
