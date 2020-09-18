Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC026FB00
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIRK4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRK4I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:56:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AD7C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:56:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJE3i-006Cxv-Fu; Fri, 18 Sep 2020 12:56:06 +0200
Message-ID: <8b7f1ab8a15a06a23b7db2fb120e3144c482d7b9.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/22] nl80211: correctly validate S1G beacon head
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:56:05 +0200
In-Reply-To: <20200908190323.15814-5-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
         <20200908190323.15814-5-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 12:03 -0700, Thomas Pedersen wrote:
> The S1G beacon has a different header size than regular
> beacons, so adjust the beacon head validator.

I've applied this already and will keep it, but you later add short
beacons - don't they need further adjustments here too?

johannes

