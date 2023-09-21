Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326887AA276
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjIUVSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjIUVS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:18:27 -0400
X-Greylist: delayed 1954 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 13:42:39 PDT
Received: from torres.zugschlus.de (torres.zugschlus.de [IPv6:2a01:238:42bc:a101::2:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B961091
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 13:42:39 -0700 (PDT)
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
        (envelope-from <mh+debian-user-german@zugschlus.de>)
        id 1qjPzr-005hRE-0E;
        Thu, 21 Sep 2023 22:09:59 +0200
Date:   Thu, 21 Sep 2023 22:09:58 +0200
From:   Marc Haber <mh+debian-user-german@zugschlus.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "exp-311223@news.muster.net" <exp-311223@news.muster.net>,
        "tychokirchner@gmail.com" <tychokirchner@gmail.com>,
        "rene@debian.org" <rene@debian.org>,
        "Juergen.bausa@online.de" <Juergen.bausa@online.de>,
        "sebastian.suchanek@gmx.de" <sebastian.suchanek@gmx.de>
Subject: Re: iwlwifi in German ICE4 trains
Message-ID: <ZQyjFmOTUsUoOXRD@torres.zugschlus.de>
References: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
 <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
 <20230424042135.4xwtbobs2p5wmnjk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230424042135.4xwtbobs2p5wmnjk@pengutronix.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I still have the problem in all ICE 4 trains with my notebook.

On Mon, Apr 24, 2023 at 06:21:35AM +0200, Uwe Kleine-König wrote:
> first of all: thanks for your prompt response.
> 
> On Sun, Apr 23, 2023 at 01:06:45PM +0000, Greenman, Gregory wrote:
> > Based on the log, I can understand that it had successfully connected to the AP
> > (supplicant management interface state: associating -> completed);
> > then there're some DHCP errors and eventually the AP sends a deauth.
> > It's hard to say what can cause it, but if you'll be able to reproduce
> > the issue, it'd be great if you could collect a trace-cmd dump with
> > this command:
> > sudo trace-cmd record -e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg
> 
> Done, see https://www.kleine-koenig.org/tmp/20230424-trace.dat for the
> resulting trace.dat file.

Would a trace.dat from my notebook help?

> > It'll be also helpfull if you'll be able to say which specific
> > modprobe option fixes the issue.
> 
> The relevant one is
> 	options iwlwifi 11n_disable=1

This is unfortunately an option that you don't want in effect all the
time as it reduces Wifi performance at home to 11g/11a typical 54
Mbit/s.

Greetings
Marc


-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
