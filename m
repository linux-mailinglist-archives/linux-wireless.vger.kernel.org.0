Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E34134548
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgAHOpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 09:45:52 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44534 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHOpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 09:45:52 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ipCak-0061UM-Mp; Wed, 08 Jan 2020 15:45:50 +0100
Message-ID: <30cc55076b4c04b4c4ff9923535c3d3bbc037222.camel@sipsolutions.net>
Subject: Re: Possible deadlock in cfg80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
Date:   Wed, 08 Jan 2020 15:45:49 +0100
In-Reply-To: <64dc212d-fde7-ab84-369c-c7cb5bf579d7@tu-ilmenau.de> (sfid-20200108_122337_992318_9DCD9168)
References: <64dc212d-fde7-ab84-369c-c7cb5bf579d7@tu-ilmenau.de>
         (sfid-20200108_122337_992318_9DCD9168)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-08 at 12:23 +0100, Markus Theil wrote:
> Hi,
> 
> while testing hostapd with hwsim, the following deadlock was reported:

I see you already sent a patch to fix this, thanks :)

johannes

