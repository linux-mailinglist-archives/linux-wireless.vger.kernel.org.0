Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633D92600BC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgIGQxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgIGQwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:52:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BCC061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 09:52:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kFKNM-000Co9-CN; Mon, 07 Sep 2020 18:52:16 +0200
Message-ID: <b7aaab23072e4c06c3cb245a3ea83f11e9ca9e7f.camel@sipsolutions.net>
Subject: Re: alternatives to screenscraping iw?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, od@zcrc.me
Date:   Mon, 07 Sep 2020 18:52:15 +0200
In-Reply-To: <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com> (sfid-20200907_182259_380510_19DC3CE1)
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net>
         <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
         <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com>
         (sfid-20200907_182259_380510_19DC3CE1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-09-07 at 21:52 +0530, Krishna Chaitanya wrote:
> 
> FYI, We have open-sourced our internal library which takes care of abstracting
> Netlink attributes, just need to define commands and event messages in JSON,
> https://github.com/bluwireless/py-genl. The initial port of all
> messages might be an effort but extending it would be easy.

Nice.

I wonder if the netlink policy export I wrote for the kernel could be
used to generate attribute descriptions? Even if it means just running a
tool in a latest kernel VM to do it.

johannes

