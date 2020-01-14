Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECFA13A26B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 09:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANIAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 03:00:13 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42726 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANIAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 03:00:13 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1irH7T-005VeX-83; Tue, 14 Jan 2020 09:00:11 +0100
Message-ID: <34040c2da85b14ff7881460efd2348b7d84b4b21.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 14 Jan 2020 09:00:10 +0100
In-Reply-To: <8ebb225f-8ec5-0897-03cd-f37bfdd94429@adapt-ip.com>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
         <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
         <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
         <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
         <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
         <8ebb225f-8ec5-0897-03cd-f37bfdd94429@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Thomas,

> Is there a list of known passing hwsim tests somewhere?
> 
> Maybe a subset of suites / tests you like to see passing as a smoke test?

Not really.

> Or do you run through the 3300+ tests and expect them all to pass?

Pretty much, yes. It takes <10 minutes on my quad-core desktop to run
using the UML time-travel mode against recent kernels.

I don't always get 100% pass on the first round, but the handful that
fails sometimes I expect to pass when running just those manually with
vm-run.sh.

johannes

