Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050B5176F87
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 07:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCCGf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 01:35:27 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53756 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgCCGf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 01:35:27 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 07588CECC8;
        Tue,  3 Mar 2020 07:44:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] net: wireless: Add module_param(mac_prefix) to
 mac80211_hwsim
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200302234946.75425-1-rkir@google.com>
Date:   Tue, 3 Mar 2020 07:35:25 +0100
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, lfy@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <70C09381-125F-427A-83AF-4882AE71DACD@holtmann.org>
References: <20200302234946.75425-1-rkir@google.com>
To:     rkir@google.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Roman,

> By default mac80211_hwsim creates N radios with
> MAC addresses like '02:00:00:nn:nn:00' where nnnn
> is incremented.
> 
> We (Android Studio Emulator) need a way to have unique
> MAC addresses. Currently in mac80211_hwsim this can
> be done by sending HWSIM_CMD_DEL_RADIO and
> HWSIM_CMD_NEW_RADIO commands.
> 
> The 'mac_prefix' parameter provides an easier way to
> make MAC address unique by specifying two octets in
> MAC address, i.e. '02:pp:pp:nn:nn:00'.

since we have an API for creating radios, wouldn’t it be better to add a kernel option to allow setting the default number of radios on module load to 0 and then let userspace create them on demand. I for example always set my testing kernel to load 0 radios.

Regards

Marcel

