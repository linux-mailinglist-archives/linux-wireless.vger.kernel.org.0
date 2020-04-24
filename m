Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C573D1B719D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDXKLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXKLY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:11:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43883C09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 03:11:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRvIo-00FSUB-Gm; Fri, 24 Apr 2020 12:11:22 +0200
Message-ID: <d720e6c495aeb8cb6d17cf44b8c15d96de48b61d.camel@sipsolutions.net>
Subject: Re: [PATCH 5/9] cfg80211: report frequency in KHz for management RX
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 24 Apr 2020 12:11:21 +0200
In-Reply-To: <20200402011810.22947-6-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
         <20200402011810.22947-6-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-01 at 18:18 -0700, Thomas Pedersen wrote:
> Expect and convert drivers to report the RX frequency to
> cfg80211_rx_mgmt() and cfg80211_report_obss_beacon() in
> KHz

I would prefer to have some inlines for this, and add
cfg80211_rx_mgmt_khz() or something.

You've had to change a lot of drivers, but I got conflicts, and you also
missed some (which may have added the code since you created the
patches, or you prepared against mac80211-next and that code was waiting
elsewhere, etc.)

I've applied patches 1-4, but please respin the rest.

johannes

