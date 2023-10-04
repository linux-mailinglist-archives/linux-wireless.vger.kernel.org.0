Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E87B8683
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbjJDR2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjJDR2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 13:28:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC544BD;
        Wed,  4 Oct 2023 10:28:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9E8C433C8;
        Wed,  4 Oct 2023 17:28:48 +0000 (UTC)
Date:   Wed, 4 Oct 2023 13:29:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004132955.0fb3893d@gandalf.local.home>
In-Reply-To: <20231004095431.1dd234e6@kernel.org>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
        <20231004092205.02c8eb0b@kernel.org>
        <20231004123524.27feeae7@gandalf.local.home>
        <20231004095431.1dd234e6@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 4 Oct 2023 09:54:31 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 4 Oct 2023 12:35:24 -0400 Steven Rostedt wrote:
> > > Potentially naive question - the trace point holds enum skb_drop_reason.
> > > The user space can get the names from BTF. Can we not teach user space
> > > to generically look up names of enums in BTF?    
> > 
> > That puts a hard requirement to include BTF in builds where it was not
> > needed before. I really do not want to build with BTF just to get access to
> > these symbols. And since this is used by the embedded world, and BTF is
> > extremely bloated, the short answer is "No".  
> 
> Dunno. BTF is there most of the time. It could make the life of
> majority of the users far more pleasant.

BTF isn't there for a lot of developers working in embedded who use this
code. Most my users that I deal with have minimal environments, so BTF is a
showstopper.

> 
> I hope we can at least agree that the current methods of generating 
> the string arrays at C level are... aesthetically displeasing.

I don't know, I kinda like it ;-)

-- Steve
