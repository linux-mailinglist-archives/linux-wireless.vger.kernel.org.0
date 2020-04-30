Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A631C0708
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3TxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgD3TxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 15:53:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72892C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 12:53:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jUFFG-002qKl-Nu; Thu, 30 Apr 2020 21:53:18 +0200
Message-ID: <b682b52e5bc75ed0fbe1c71561df9c7aba54eae5.camel@sipsolutions.net>
Subject: Re: [PATCH 09/10] mac80211: determine chantype from HE operation in
 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Apr 2020 21:53:17 +0200
In-Reply-To: <a5d931f074cbce8073abd8257555d3bb@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-10-git-send-email-rmanohar@codeaurora.org>
         <3b2b90685e55d3eae22171cf46340af5154bb59f.camel@sipsolutions.net>
         <a5d931f074cbce8073abd8257555d3bb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-29 at 17:18 -0700, Rajkumar Manoharan wrote:
> On 2020-04-29 07:34, Johannes Berg wrote:
> > On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
> > > In 6 GHz band, determine chandef from 6 GHz operation information
> > > of HE operation element.
> > 
> > Yeah... I had this too. Oh well.
> > 
> Thanks for feedback. Have few more changes on top this series.
> Before posting next version, would prefer to bundle with your changes. 
> thoughts?

I guess post whatever you have already? That shouldn't be any real work
:-)

And then I can compare to what I have internally already. I guess I'll
just send that out too so you can see it.

johannes

