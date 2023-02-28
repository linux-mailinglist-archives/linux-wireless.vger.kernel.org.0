Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215C6A5E12
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjB1RQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB1RQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:16:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F571EBC2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ohv6AJiYYMUprR2DRlLmGpn7tQUQjpwcZZC2dpPeMBQ=;
        t=1677604615; x=1678814215; b=au1vUMYx6VDV8KwPr0W7WywoqQvRKeBl25vuclV++IL3y7a
        nlZUfZ0oTfHaRoI3zxtzDCAYSp+0muFngDHf//ojbaqWcKfBSkNvaGvHSkFfrgimvlwf5Yqwlmbx9
        m4i8v1Alv82jvcWlybPHHntcT2Vga7raToBKO+PW5Xy8KznJl5+CFF7ZLwsDKxSU1z1z87NskrzcK
        jG5CDX3c+/RnxI+gRJXUa/7SEMRAlOV3kBOVRkTk1c9V8L+hp+Wi5DColYkS5J2GzlG7rY3VSMKYP
        ufp98mh+yB10JRCWYpAs9F/xcXZzf1jZCChDGEFry93DEwqxD1wQfDamUokw0Wtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pX3ar-0083cJ-0W;
        Tue, 28 Feb 2023 18:16:49 +0100
Message-ID: <8a01fd09878f6e73cac716ddc9fa7b2681eff943.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: cfg80211: use struct_size and size_sub for
 payload length
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Date:   Tue, 28 Feb 2023 18:16:48 +0100
In-Reply-To: <20230228162827.3876606-2-jacob.e.keller@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
         <20230228162827.3876606-2-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This shouldn't have "wifi: cfg80211:" prefix but rather "wifi:
qtnfmac:"=C2=A0 :-)

johannes
