Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5210EC04F6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfI0MQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 08:16:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54268 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0MQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 08:16:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iDpAS-0007CY-Kb; Fri, 27 Sep 2019 14:16:12 +0200
Message-ID: <49ded6ae8a23c29168ab7061235292ac7a853e0f.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim: packets being transmitted through the monitor
 interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 27 Sep 2019 14:16:11 +0200
In-Reply-To: <CAK8U23ZyFnYt+ePreGjFA2VFXnpu21SPthscvJhP-5xjQCb0OA@mail.gmail.com> (sfid-20190927_035500_898243_B3F3D103)
References: <CAK8U23ZyFnYt+ePreGjFA2VFXnpu21SPthscvJhP-5xjQCb0OA@mail.gmail.com>
         (sfid-20190927_035500_898243_B3F3D103)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-09-26 at 22:54 -0300, Ramon Fontes wrote:
> Hello,
> 
> I've noticed that packets transmitted between two clients connected to
> a hostapd AP are also transmitted (injected) through the monitor
> interface. Is this expected behavior? 

You mean on 'hwsim0'? That interface is just for monitoring what's
happening on the 'virtual air', so yes.

> I can easily modify such
> behavior by changing mac80211_hwsim, but it works only with hwsim0. On
> the other hand, if I create a monitor interface via iw it doesn't
> work.

The two are completely different/unrelated things.

johannes

