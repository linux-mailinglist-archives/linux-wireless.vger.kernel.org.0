Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10BAC3205
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfJALLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:11:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59952 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJALLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:11:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFG44-0006Ka-VN; Tue, 01 Oct 2019 13:11:33 +0200
Message-ID: <5bb044d9ade19dd4e15533ba5a042605be01d477.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with
 a better moving average
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Tue, 01 Oct 2019 13:11:32 +0200
In-Reply-To: <8017042b74a05df72a7ebfb5ec21fc7cc088ed4e.camel@sipsolutions.net>
References: <20190929154646.90901-1-nbd@nbd.name>
         <20190929154646.90901-2-nbd@nbd.name>
         <f40bd542d0d13f5be701de41b8870b0bd1f34230.camel@sipsolutions.net>
         <017c1a59-edf2-0a1a-aa8c-3c32e57d6cd0@nbd.name>
         <8017042b74a05df72a7ebfb5ec21fc7cc088ed4e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 13:06 +0200, Johannes Berg wrote:
> On Tue, 2019-10-01 at 12:52 +0200, Felix Fietkau wrote:
> > Might be useful, yes. The main issue here is that the period / window
> > size has to be hardcoded through the coefficient values, unless we find
> > a way to do floating point math, including exp() and cos() at compile
> > time, including conversion to fixed point.
> 
> Works fine for me?
> 
[snip]

I guess really the question is - how do we ensure that happened and fail
if it didn't?

johannes

