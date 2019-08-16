Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBED8F9E6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 06:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHPE36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 00:29:58 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:53789 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPE35 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 00:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=3XlZYMRFin0Z7cZTXT/iQxq3F7h241nqtpeIkiCO2wE=;
        b=pvV6zT5/9Bw1KUGZvMVi004mF7dzbzR4S99IgiKoAKTi6YCuZykp4ltKnwmnIOKFkw3PPkc7tcccvH3JfF1F+m7disropIsUbmPbRKKoLDNl5b4VT1uyBRZGoqKi1HP56SpTdkd/CA6xwoco5EBbk+IqDFhVm3ffdSI8rO01BPw=;
Subject: Re: Implementing Mikrotik IE
To:     Josef Miegl <josef@miegl.cz>, linux-wireless@vger.kernel.org
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
Date:   Fri, 16 Aug 2019 06:07:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f31:fa00:e41f:2151:796d:3095]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hyTX6-0007UE-4z; Fri, 16 Aug 2019 06:08:08 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

Since i already have done this for dd-wrt for mac80211 i can tell you, 
its not easy but possible. the most easy way for broadcasting a custom IE
is just adding a custom IE with its properties to the hostapd 
configuration. it does allow to set such properties
so you dont need to change anything in mac80211 which requires some evil 
hacks

Am 15.08.2019 um 17:28 schrieb Josef Miegl:
> I've been trying to implement Mikrotik IE. It is a vendor IE that
> carries stuff like radio name. Even though it is Mikrotik specific, UBNT
> has a patch for madwifi:
> https://github.com/jhairtt/ubnt-hal-0.7.379/blob/master/patches/madwifi-dfs-r3319-20080201/074-mtik-ie.patch
>
> The IE is sent in beacon and assoc/reassoc frames. I think the correct
> place for this is mac80211, but I'm not sure how should I expose a
> switch to this functionality. Is there something like ioctl, or do I have
> to implement a switch in nl80211, then in cfg80211 and then finally in
> mac80211?
>
> Any advice is greatly appreciated.
>
