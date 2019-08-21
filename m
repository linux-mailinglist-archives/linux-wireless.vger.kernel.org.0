Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11B9867F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfHUVTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 17:19:44 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32932 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfHUVTo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 17:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566422382; bh=pfSr/8QR/7bC3Cbk0WW2HLGqTy3HbVFdSeT7iU4yG6I=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=rUXUWlkqb198E0ycJPEpCDR6oglO5tGqvSR5Xns2QgUQ3GJT27tyFn14wIMY9VAG1
         UWofvOoWQTZN8vEXFsn7o26jmeM4Wnhadc4udz/W4+sb5zOJ/4kda6pWweyxr+lSpc
         A+F3CDDLhaCK6qxJux6+JyUhO395EGceSIDqTM0+p1w6D8YUCRMT9b5zdiirkJuk2D
         nHv1SEcOm/JimHhaCW8NJUN5mIzmJJOHgE0k4CG9LeWtDAoj6hOS/Wi6dvx30zZkgO
         gVhNSk9i1vPBnQOSYhL1dfDzbbkKjup/3ifNLhJ33PaSyP0pWtSdKMipWQ721xzzHU
         Hu+D9DFp5hKKg==
Date:   Wed, 21 Aug 2019 23:19:40 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain> <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de> <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain> <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de> <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain> <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net> <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de> <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Implementing Mikrotik IE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Josef Miegl <josef@miegl.cz>
Message-ID: <47334E8F-8272-4234-9A41-89F571F5A856@miegl.cz>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Forgot to add:
This is what the mikrotik AP reports:
Disconnecting, unicast key exchamge timeout
Josef
