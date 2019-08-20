Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0E957FC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfHTHN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 03:13:58 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59412 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 03:13:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzyKx-0008Og-L7; Tue, 20 Aug 2019 09:13:47 +0200
Message-ID: <b2a2abf85761a3101afd11ff513d5fef62c6cd64.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 09:13:46 +0200
In-Reply-To: <42653433-58b5-10f0-288e-1e5731e012d1@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
         <20190629195015.19680-4-alexander@wetzel-home.de>
         <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
         <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
         <ae321cd5-6ef4-87c5-98ec-dbac37e83c6d@wetzel-home.de>
         <eb0481b1928b0554daeda59cfc1d631e44bb2bdd.camel@sipsolutions.net>
         <42653433-58b5-10f0-288e-1e5731e012d1@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> You are thinking about keeping the tx API untouched and modify the key 
> install logic?
> Just prevent the firmware to activate a key for Tx when it's installed 
> and notify the firmware by some means when the key can be used for Tx 
> and then switch everything to the new key?

Something like that, yes.

> I guess there is no practical way I can get access to the firmware code, 
> correct? 

There isn't, yeah.

> For me it sounds harder than the optional flag extension I had 
> in mind for the new tx API.

Much more of the TX path is actually wired into the hardware, rather
than being software. I'm not sure how much of this (key selection)
really is though.

> So let's wait and see what you can turn up. Till then we have more than 
> enough other cards supporting Extended Key ID:-)

Yeah. I'll take a look, but I can't promise right now to work on it high
priority.

johannes

