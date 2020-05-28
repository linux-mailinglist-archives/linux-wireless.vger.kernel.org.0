Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A11E64BB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbgE1Ox3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391363AbgE1Ox1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:53:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB9C08C5C8
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:53:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJuP-004vfq-Na; Thu, 28 May 2020 16:53:25 +0200
Message-ID: <b2cd827da3d73a9e83a9fc54f79485caee17377e.camel@sipsolutions.net>
Subject: Re: iwlwifi: 8265: unexpected LLC packets TX'ed in monitor mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marco <marco@tampabay.rr.com>, linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 16:53:24 +0200
In-Reply-To: <C32FKI01HMGA.U0TCA9AIO8BX@b1>
References: <C32FKI01HMGA.U0TCA9AIO8BX@b1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 10:26 -0400, Marco wrote:
> 
> > I think these are somehow related to calibrations in the device.
> 
> Are you perhaps implying that I can alter calibration settings to fix
> this problem?  If you have any pointers to this it would be
> appreciative.

No, I don't know if this is possible. I'm just telling you what I think
the reason for them is.

> Regardless though, I would still expect the default behavior to not
> emit packets when in monitor mode, unless the user directs it to;
> similar to what I've seen from other wifi chipsets.

I have no idea precisely why (for what kind of calibration) these are
transmitted and if it could be changed, I guess you could try contacting
Intel's customer support?

johannes

