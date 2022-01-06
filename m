Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78142486D12
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 23:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiAFWKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbiAFWKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 17:10:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D2C061245
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jan 2022 14:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kfHlebS4gOE+6J4q4dl4zZGNGU2ALNEHGdnL49Sup+w=;
        t=1641507039; x=1642716639; b=BYATg3Ymqh7siMTMgSin4GDN7LIFqClurw++RemoAY4jBAL
        eVPwD2BWkoH8Dc14z4ASlxpc4hr+si3J6ZzgxMDQvoeKyjdfAtn5DIUGNDrCqgIFCuhniJAFV31Kx
        DUoq6dUJK+xW7SsRIEC8Mc/z3LypbXfJsW9sOnQWCkc7lWFL5rKp5d31ChvIi+h7s1NlLkmQHi0eL
        GsikUYWwlQ8GYaOsCnvnNIIQrWbiAVU6APN/RkGBJIoiIXgbPZWHFVcHsj2Hz5edx73vPdZnbYysc
        13xFHoEf3ILoIiyN7HL8D2WobFmFMoxI2OF/yTQMKTyHCwzsepPmDRw0J6mccJ8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n5axx-002gPU-Rl;
        Thu, 06 Jan 2022 23:10:38 +0100
Message-ID: <9a4fe215e6adf0df7f5dd322313004669edb13bf.camel@sipsolutions.net>
Subject: Re: 802.11k, wpa_supplicant and iwlwifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael Yartys <michael.yartys@protonmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 06 Jan 2022 23:10:36 +0100
In-Reply-To: <zPg00UzBCn11SUYFks7vJunMuHmpeG8n6RCnf05uqUMjL8LO_XtWmhlQbDRWKO9_DwPvArE6GfghPZFlq871XKoujd4e6KSWPp8fabQkJOI=@protonmail.com>
References: <zPg00UzBCn11SUYFks7vJunMuHmpeG8n6RCnf05uqUMjL8LO_XtWmhlQbDRWKO9_DwPvArE6GfghPZFlq871XKoujd4e6KSWPp8fabQkJOI=@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-12-21 at 14:46 +0000, Michael Yartys wrote:
> Hi
> 
> From what I understand, wpa_supplicant only processes 802.11k frames
> if the underlying driver indicates support for it through a flag. I
> haven't really found any information on whether this is the case for
> iwlwifi. Does anybody know if iwlwifi supports this? I don't know if
> this also depends on which wireless card that I use, so I'll include
> it in case it does: Intel 7260AC.
> 

wpa_supplicant will advertise RRM support
(WLAN_EID_RRM_ENABLED_CAPABILITIES) if the driver has certain
capabilities:

        if (!((wpa_s->drv_rrm_flags &
               WPA_DRIVER_FLAGS_DS_PARAM_SET_IE_IN_PROBES) &&
              (wpa_s->drv_rrm_flags & WPA_DRIVER_FLAGS_QUIET)) &&
            !(wpa_s->drv_rrm_flags & WPA_DRIVER_FLAGS_SUPPORT_RRM)) {
                wpa_printf(MSG_DEBUG,
                           "RRM: Insufficient RRM support in driver - do not use RRM");
                return;
        }


That's almost certainly not true for 7260, as far as I remember that
device predates our work to support RRM, and so the firmware wouldn't
have the corresponding capabilities.

johannes
