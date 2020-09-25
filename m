Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7A278254
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIYIMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 04:12:48 -0400
Received: from s2.neomailbox.net ([5.148.176.60]:38996 "EHLO s2.neomailbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgIYIMs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 04:12:48 -0400
X-Greylist: delayed 1059 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 04:12:47 EDT
Subject: Re: [PATCH] crda: don't memset ctx before releasing members
To:     "Luis R . Rodriguez" <mcgrof@do-not-panic.com>
Cc:     linux-wireless@vger.kernel.org, Kelvin Chui <kelvin.chui@kaiwoo.ai>
References: <20200624221221.16419-1-a@unstable.cc>
From:   Antonio Quartulli <a@unstable.cc>
Autocrypt: addr=a@unstable.cc; prefer-encrypt=mutual; keydata=
 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
 8QRnNzBkJk/ejM/Es0pjrgC/I5iDlHw=
Message-ID: <eec24cef-be5c-cc3f-a0fa-cd931efa2fab@unstable.cc>
Date:   Fri, 25 Sep 2020 09:54:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200624221221.16419-1-a@unstable.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi guys,

On 25/06/2020 00:12, Antonio Quartulli wrote:
> reglib_free_regdb_ctx() is currently memsetting the passed context to
> all 0s and then attempts to unmap/release its members.
> 
> Obviouly this can't work, because after the memset() all ctx's members
> will not be useful anymore. Attempting to release them may actually lead
> to crashes. Even if no crash should happen, this operation will still
> result in memleaks.
> 
> Fix this issue by removing the memset() at all, thus leaving the members
> intact so that they can be properly released.
> 
> Signed-off-by: Kelvin Chui <kelvin.chui@kaiwoo.ai>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>


Just checking if this patch is still of interest and if there is
something I could do to get it merged?

Best Regards,


-- 
Antonio Quartulli
