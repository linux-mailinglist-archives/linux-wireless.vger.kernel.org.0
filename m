Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19D13D528
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 08:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAPHmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 02:42:00 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:47944 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgAPHl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 02:41:59 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1irzmv-00BTj7-Ff; Thu, 16 Jan 2020 08:41:57 +0100
Message-ID: <11f9a3969270b7f0cb60e1b91ac31aea3bc94a93.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 16 Jan 2020 08:41:56 +0100
In-Reply-To: <385589b2-e8a2-1e39-d347-f3353bc681aa@adapt-ip.com>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
         <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
         <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
         <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
         <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
         <8ebb225f-8ec5-0897-03cd-f37bfdd94429@adapt-ip.com>
         <34040c2da85b14ff7881460efd2348b7d84b4b21.camel@sipsolutions.net>
         <385589b2-e8a2-1e39-d347-f3353bc681aa@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-15 at 21:23 -0800, Thomas Pedersen wrote:
> On 1/14/20 12:00 AM, Johannes Berg wrote:
> > Hi Thomas,
> > 
> > > Is there a list of known passing hwsim tests somewhere?
> > > 
> > > Maybe a subset of suites / tests you like to see passing as a smoke test?
> > 
> > Not really.
> > 
> > > Or do you run through the 3300+ tests and expect them all to pass?
> > 
> > Pretty much, yes. It takes <10 minutes on my quad-core desktop to run
> > using the UML time-travel mode against recent kernels.
> > 
> > I don't always get 100% pass on the first round, but the handful that
> > fails sometimes I expect to pass when running just those manually with
> > vm-run.sh.
> 
> Thanks, I'll give UML time-travel mode a try.

FWIW, I applied your patches yesterday. There was one issue remaining
uncovered by them, but it wasn't actually related to your patches, just
related to the test sending too many frames. I sent a workaround to the
hostap list and also the "mac80211: use more bits for ack_frame_id" to
the kernel to fix that.

johannes

