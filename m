Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DC78F73
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfG2Pgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 11:36:42 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35602 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfG2Pgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 11:36:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hs7hY-000765-FM; Mon, 29 Jul 2019 17:36:40 +0200
Message-ID: <c99907684210a17506840c6f115d648011fbd4cd.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/3] nl80211: Limit certain commands to interface
 owner
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Mon, 29 Jul 2019 17:36:38 +0200
In-Reply-To: <443c450b-31f8-f059-e4c9-83eee00bfce2@gmail.com> (sfid-20190729_173543_239398_E19DF247)
References: <20190722113312.14031-1-denkenz@gmail.com>
         <20190722113312.14031-2-denkenz@gmail.com>
         <443c450b-31f8-f059-e4c9-83eee00bfce2@gmail.com>
         (sfid-20190729_173543_239398_E19DF247)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I noticed that the other patches in this series got applied.  Was this 
> one left out on purpose?

Yeah, I left out a few that I wanted to review more carefully.

I'll get to it this week (because I'm on vacation after that).

johannes

