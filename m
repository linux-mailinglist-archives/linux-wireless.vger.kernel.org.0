Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09272D452
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjFLWWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 18:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjFLWWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 18:22:01 -0400
X-Greylist: delayed 13747 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 15:21:58 PDT
Received: from 10.mo581.mail-out.ovh.net (10.mo581.mail-out.ovh.net [178.33.250.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0410B
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 15:21:58 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.4.98])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 5A2FC2504B
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 18:23:27 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7pw2s (unknown [10.110.115.83])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1950F1FDC7;
        Mon, 12 Jun 2023 18:23:27 +0000 (UTC)
Received: from RCM-web3.webmail.mail.ovh.net ([178.33.236.78])
        by ghost-submission-6684bf9d7b-7pw2s with ESMTPSA
        id U53TBZ9ih2ThsQEAYGFhMA
        (envelope-from <rafal@milecki.pl>); Mon, 12 Jun 2023 18:23:27 +0000
MIME-Version: 1.0
Date:   Mon, 12 Jun 2023 20:23:26 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kvalo@kernel.org,
        f.fainelli@gmail.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: wireless: bcm4329-fmac: add
 ieee80211-freq-limit property
In-Reply-To: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
References: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f19c93cc90d6fa92e7e0430a12ec838b@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 93.159.183.33
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7106398739039759254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefgueelueetteefueehhffhgfetvdegjeefleffuedvhfeuffdvheegueevuefhleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdelfedrudehledrudekfedrfeefpddujeekrdeffedrvdefiedrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023-06-11 14:37, Christian Lamparter wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> The driver supported this since ~2017 by
> commit 0f83ff697356 ("brcmfmac: use wiphy_read_of_freq_limits to
> respect limits from DT")
> 
> This property is already being used by:
> arch/arm/dts/bcm4709-netgear-r8000.dts
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

I've already submitted patch for that:
https://patchwork.kernel.org/project/linux-wireless/patch/20230602135925.14143-2-zajec5@gmail.com/

This patch isn't needed anymore.


> ---
>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index fec1cc9b9a08..44e5f6677289 100644
> --- 
> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ 
> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -15,6 +15,9 @@ description:
>    These chips also have a Bluetooth portion described in a separate
>    binding.
> 
> +allOf:
> +  - $ref: ieee80211.yaml#

FWIW:
This isn't enough without changing additionalProperties to 
unevaluatedProperties.


>  properties:
>    compatible:
>      oneOf:
> @@ -63,6 +66,8 @@ properties:
>      description: Name for the OOB IRQ, this must be set to 
> "host-wake".
>      const: host-wake
> 
> +  ieee80211-freq-limit: true

FWIW:
You don't need it here with allOf.


>    brcm,drive-strength:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: Drive strength used for the SDIO pins on the device 
> in mA.
