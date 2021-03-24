Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058B34835D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhCXVDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbhCXVDR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 17:03:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952BC06174A;
        Wed, 24 Mar 2021 14:03:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lPAeg-002mf1-1d; Wed, 24 Mar 2021 22:03:06 +0100
Message-ID: <dbde688c9525fa2b9c1386fc95828b1851531f13.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml
 conversion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Date:   Wed, 24 Mar 2021 22:03:05 +0100
In-Reply-To: <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
References: <cover.1615752835.git.lorenzo@kernel.org>
         <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-03-14 at 21:21 +0100, Lorenzo Bianconi wrote:
> 
> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/ieee80211.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common IEEE 802.11 Binding
> +
> +maintainers:
> +  - Johannes Berg <johannes@sipsolutions.net>

Heh, now I realize why I got CC'ed on these patches.

I'm not sure that's really all that appropriate? I may be the wireless
stack maintainer, but I really don't know much about DT, and so I'm not
convinced that this entry helps anyone...

johannes

