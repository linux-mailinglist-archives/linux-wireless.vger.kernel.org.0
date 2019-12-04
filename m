Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2E1125E3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDIuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 03:50:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45104 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDIuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 03:50:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icQMY-0004Oi-W7; Wed, 04 Dec 2019 09:50:23 +0100
Message-ID: <4a007a507788461348a68076b2a1c40dff9c6de3.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix double-free after changing network
 namespace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stefan =?ISO-8859-1?Q?B=FChler?= 
        <stefan.buehler@tik.uni-stuttgart.de>
Cc:     linux-wireless@vger.kernel.org,
        Stefan =?ISO-8859-1?Q?B=FChler?= <source@stbuehler.de>
Date:   Wed, 04 Dec 2019 09:50:21 +0100
In-Reply-To: <22d78eff-9975-e2eb-5093-b19f93831bce@tik.uni-stuttgart.de>
References: <20191126100543.782023-1-stefan.buehler@tik.uni-stuttgart.de>
         <22d78eff-9975-e2eb-5093-b19f93831bce@tik.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-12-04 at 09:26 +0100, Stefan Bühler wrote:
> 
> Any status update for this?  Anything I can do?  Should I resubmit this
> with "Cc: stable@vger.kernel.org"?

No, it's fine, but we're in the middle of the merge window, I'm waiting
for some merge backs etc.

johannes

