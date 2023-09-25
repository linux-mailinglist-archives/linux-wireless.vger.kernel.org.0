Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F07C7ADF62
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjIYTEA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTD7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 15:03:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA793
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5a1W475v5LR0WGl2kM8cTqBJYjejnKzVULCckeWnUtY=;
        t=1695668633; x=1696878233; b=qE4upvQ0HgIyYPErI0uwqxSGSxVUEt3JTBJyV6lMEygiBLq
        t9YGB+r7zZZq3OOxtLjmyg31RyKi4Hyk3Y5mL7fHL5pBd4rMrBNVD3lM+mGKnj2BgX4e7flOxA5Ov
        fV6WzeqHJN1tQk+JUHQ6SI1PKijBHfP6o4gCPr6FZBD8ILzC9it+Dwwyk3DGBU0S3CAkhPz8kb9MB
        xGAPqkR7n7zjwwKYXD3bL7jZt0FtLJk9qh/vkfgSBnAu7RIzXCQUIVRtRtGT5ZooKbuDBsYSEdp9k
        WHhp2FwmT9RlXe1px6dTGBMIeHLAHXl3Z4fd1GzncpV4OUdKJpSIwdQMxXCzn4wA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qkqs1-003y5g-2Z;
        Mon, 25 Sep 2023 21:03:49 +0200
Message-ID: <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
Subject: Re: Microcode SW error since Linux 6.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Antoine =?ISO-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
        linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>, ilan.peer@intel.com
Date:   Mon, 25 Sep 2023 21:03:48 +0200
In-Reply-To: <8734z29jx7.fsf@angela.anarc.at>
References: <87ttrncuc8.fsf@angela.anarc.at>
         <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
         <87jzsf9dme.fsf@angela.anarc.at>
         <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
         <8734z29jx7.fsf@angela.anarc.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-09-25 at 14:39 -0400, Antoine Beaupr=C3=A9 wrote:
> > Did that patch help?
>=20
> I haven't tried, to be honest. It's been years since I compiled a
> kernel, so I haven't actually seriously considered it. But I can
> definitely put that on my list if it would be useful for you!

Heh ok. Well we can also try it I guess. Or reason our way through it,
but I'm pretty sure something like that should be done here.

> > Yes, you can ... but I mean, we still do want to consider this a bug, I
> > think, since we explicitly built the thing to load the older firmware.
> > It just gets _far_ less testing.
>=20
> Got it, happy to play guinea pig a little further if that's useful.
>=20

Well you might want to go for the extra stability instead :-) I'm kind
of thinking along the lines of "if you can download the next wifi
firmware with the current one, that's probably good enough". :)

johannes
