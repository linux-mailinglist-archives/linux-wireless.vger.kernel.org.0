Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262FA50905
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfFXKgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 06:36:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53472 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFXKge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 06:36:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfMKv-0007P1-2f; Mon, 24 Jun 2019 12:36:33 +0200
Message-ID: <693753473768100f07de573dd74bf4033618aed8.camel@sipsolutions.net>
Subject: Re: [PATCH] Add SPDX identifiers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 24 Jun 2019 12:36:32 +0200
In-Reply-To: <CAGm1_ksic4xcVdaPAObwwNdaQ19E3ZiK97SkmVmp8kz6H2KpOw@mail.gmail.com> (sfid-20190624_120805_586448_B9232B91)
References: <20190620130148.1674-1-yegorslists@googlemail.com>
         <90ccc515bb26b212b537fc1b0287afaa0f86fdf8.camel@sipsolutions.net>
         <CAGm1_ksic4xcVdaPAObwwNdaQ19E3ZiK97SkmVmp8kz6H2KpOw@mail.gmail.com>
         (sfid-20190624_120805_586448_B9232B91)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > You haven't included any documentation that says what the SPDX
> > identifier, and specifically the "ISC" tag means in the context of the
> > project, and it's not even the same license text as on spdx.org.
> 
> What about such definition?
> 
> SPDX short-form identifiers provide information about licenses that
> apply to the source file.

It just bothers me that this isn't self-contained - you always have to
go to spdx.org to really figure out what it means.

> As for the exact license I wasn't sure myself. Buildroot identifies it
> as ISC [1]. How do you define its license in SPDX terms?

Not sure. Maybe you cannot?

spdx.org says "ISC" is the license that says:

[...] THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS [...]

while the license here says:

[...] THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS [...]

(and the same in one other place)


This might just be an oversight on spdx.org, since the license with "THE
AUTHOR" *is* typically referred to as "ISC" (e.g. 
https://opensource.org/licenses/ISC), but it still means it's not
actually identical?

Maybe spdx.org should switch, but then it changing the license text ...
what if anyone refers to it already?

It's all not very obvious to me.

The kernel side-stepped it and said "let's make it all self-contained",
which seems saner to me.

johannes

