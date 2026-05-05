Return-Path: <linux-wireless+bounces-35891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JTmGoC2+WmNBAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 11:21:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C84C97FD
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 499493003608
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0FC2EB5B8;
	Tue,  5 May 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV84AMb4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652128AAEB;
	Tue,  5 May 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972552; cv=none; b=OjfwaMMWopybJEglCBCE9CaRKFbMWY6WutC484JU8zcgbCIWV72wZee6D/wkAKsjBzS18/41+aZLdMkXkiymER0RzuJyAfW/2CWr8tCRo+7RapPBquTtD3dMUf7fXcPJTnyt8ZvyhyiCk1Uc/MeBSB6YddtEgeXJ+ApkMyklf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972552; c=relaxed/simple;
	bh=RZhn/MoomGQ6CMXxWuqhJQzCY4sAWY2/7i1X8rSJGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsM9GZDYd5xpmSOzZF5Zq9f+X1RBLjjlFsmnb04yQXAIji07vET4jY2dXUYj2wn65EKAl+TbD1BGgEYRxCVmB5fMQPlByayqtpddbzvuwazqpCFTsqjsPhMyfTuns/JV7+KIpJ7t2LTP4DDKw1ipItoRKnRY2Z7BwCT/BysedWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV84AMb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6CBC2BCB4;
	Tue,  5 May 2026 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777972552;
	bh=RZhn/MoomGQ6CMXxWuqhJQzCY4sAWY2/7i1X8rSJGsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV84AMb473gRuTHXmvw3SSiLKl4x/wt6wy71q1K5YQZnlPdZpYx3SnShaPD6ktZNm
	 utrajB0IzmG6cfa124DwfhzmjiVoxZMarlm15Fa8A0Uj9fygguG9AyueZl2Jz2kAT7
	 9DsGhBYGx70jbBk+kByDyfJWrpcbXxY2t4xdK4j3h08T437ZxKfn5EDJvQN+g13BdH
	 dzKYwxawg827nvTu9VtqA03sKYz6iI3tnVoYq3rcRU4jF/BCttxxlS8u58dAhS8Zzq
	 WLwwTK/BleH8Ficm2chltK47JPLq9LfEPNUkHDbFIorpWoKUmGcQQqtBxrb1A/V7ev
	 h0gVxDKGQUsmQ==
Date: Tue, 5 May 2026 11:15:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Avinash Bhatt <avinash.bhatt@intel.com>
Cc: devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	johannes@sipsolutions.net, miriam.rachel.korenblit@intel.com, linux-kernel@vger.kernel.org, 
	kobi.guetta@intel.com, emmanuel.grumbach@intel.com
Subject: Re: [PATCH v2 1/3] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Message-ID: <20260505-nano-seal-of-speed-7d5bc8@quoll>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260504095327.30892-2-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260504095327.30892-2-avinash.bhatt@intel.com>
X-Rspamd-Queue-Id: A85C84C97FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35891-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 12:53:25PM +0300, Avinash Bhatt wrote:
> Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe
> adapters.

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/=
bindings/submitting-patches.rst#L18

Just describe hardware.

>=20
> The binding documents OEM platform configuration properties for

No, describe hardware.

> platforms that use Device Tree instead of platform firmware
> methods. All properties mirror the existing equivalents in
> structure and semantics, covering SAR power limits (intel,wrds),
> 6 GHz AP type support (intel,uats), static power limit
> (intel,splc), channel puncturing (intel,wcpe), 320 MHz per-MCC
> enablement (intel,wbem), ETSI SRD channel configuration
> (intel,srd), 6-7 GHz UHB country enable bitmask (intel,6e-uhb),
> and additional regulatory override properties.
>=20
>=20
> Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
> ---
>  .../bindings/net/wireless/intel,iwlwifi.yaml  | 430 ++++++++++++++++++
>  1 file changed, 430 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,=
iwlwifi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi=
=2Eyaml b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> new file mode 100644
> index 000000000000..210063c6183d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml

Filename should match actual device compatibles. iwlwifi is driver, so
not really relevant here.

> @@ -0,0 +1,430 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2026 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/intel,iwlwifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel iwlwifi PCIe Wi-Fi devices


There is no such thing as "iwlwifi" device. Google for it - I see
"Intel=C2=AE Wireless Wi-Fi Drivers for Linux".

Again, describe hardware.


> +
> +maintainers:
> +  - Avinash Bhatt <avinash.bhatt@intel.com>
> +
> +description:
> +  Intel iwlwifi IEEE 802.11be discrete Wi-Fi adapters connected over PCI=
e.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci8086,272b
> +
> +  reg:
> +    maxItems: 1
> +
> +  intel,wrds:
> +    description: |
> +      Wi-Fi Regulatory Domain Settings (WRDS). SAR (Specific Absorption =
Rate)
> +      transmit power limits per antenna chain and frequency subband. Val=
ues
> +      are 8-bit unsigned in units of 0.125 dBm.
> +
> +      Revision 3 layout: 4 chains x 12 subbands =3D 50 cells total.
> +      Chain A and Chain B are the two physical antenna paths; CDB Chain A
> +      and CDB Chain B carry separate limits for simultaneous dual-band
> +      operation.
> +
> +      Header (2 cells):
> +        [0] revision - structure revision, must be 0x03
> +        [1] mode     - bit 0: 0 =3D SAR disabled, 1 =3D SAR enabled;
> +                       bits [8:1]: set to 0
> +
> +      Followed by 4 chains in order: chain_a, chain_b, cdb_chain_a,
> +      cdb_chain_b, each containing 12 subband values:
> +
> +      Subband index to frequency range mapping:
> +        [0]  2.4 GHz  ch  1-13   (2412-2472 MHz)
> +        [1]  5 GHz    ch 36-64   (5180-5320 MHz, UNII-1/2)
> +        [2]  5 GHz    ch 68-96   (5340-5480 MHz, UNII-2)
> +        [3]  5 GHz    ch 100-144 (5500-5720 MHz, UNII-2e)
> +        [4]  5 GHz    ch 149-188 (5745-5940 MHz, UNII-3/4)
> +        [5]  6 GHz    ch  1-45   (5955-6175 MHz, UNII-5 lower)
> +        [6]  6 GHz    ch 49-93   (6195-6415 MHz, UNII-5 upper)
> +        [7]  6 GHz    ch 97-115  (6435-6525 MHz, UNII-6)
> +        [8]  6 GHz    ch 117-151 (6535-6705 MHz, UNII-7 lower)
> +        [9]  6 GHz    ch 153-183 (6715-6865 MHz, UNII-7 upper)
> +        [10] 6 GHz    ch 185-233 (6875-7115 MHz, UNII-8)
> +        [11] 6 GHz    ch 237-253 (7135-7215 MHz, UNII-9)
> +    allOf:

Don't invent your own syntax. Drop. There are no other bindings using
it, so why are you coming with something completely new?


> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 50
> +        maxItems: 50
> +
> +  intel,uats:
> +    description: |
> +      UHB (Ultra High Band / 6 GHz) AP Type Support (UATS). Per-country
> +      enablement matrix for 6 GHz AP types. Uses byte array format
> +      (DTS [ ... ] notation).
> +
> +      In the 6 GHz band, regulatory rules differ per country and per AP
> +      type: AFC (Standard Power), LPI (Low Power Indoor), and VLP (Very
> +      Low Power). This matrix encodes which AP types are permitted to
> +      operate in each country.
> +
> +      Revision 1 layout (339 bytes total):
> +        [0]   revision    - structure revision, must be 0x01
> +        [1+]  country_map - 338-byte matrix encoding AP type allowances
> +                            per country.
> +
> +                            Countries are identified by their ISO 3166-1
> +                            alpha-2 code (two letters, A-Z each). The
> +                            matrix covers all 26x26 =3D 676 possible
> +                            two-letter combinations (AA..ZZ), most of
> +                            which are unused (set to 0x0).
> +
> +                            Each country entry is 4 bits (a nibble). Two
> +                            entries are packed per byte: the low nibble
> +                            holds the even-indexed entry, the high nibble
> +                            holds the odd-indexed entry. For example,
> +                            byte value 0x53 means: entry[even]=3D0x3,
> +                            entry[odd]=3D0x5.
> +
> +                            The matrix is stored column-major by first
> +                            letter: all 26 second-letter variants for
> +                            first letter 'A' occupy bytes [0..12], then
> +                            first letter 'B' occupies bytes [13..25],
> +                            and so on for all 26 first letters.
> +                            26 columns x 13 bytes =3D 338 bytes total.
> +
> +                            Each 4-bit nibble encodes AP type allowances
> +                            for one country:
> +                              bit 0: AFC (Standard Power AP) allowed
> +                              bit 1: VLP (Very Low Power AP) allowed
> +                              bit 2: LPI (Low Power Indoor AP) allowed
> +                              bit 3: reserved, must be 0
> +
> +                            Note: each bit is only effective when the
> +                            corresponding control bit in intel,6e-uhb
> +                            is also set (bit 30 for AFC, bit 29
> +                            for VLP, bit 31 for LPI country-by-country
> +                            mode).
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8-array
> +      - minItems: 339
> +        maxItems: 339
> +
> +  intel,srd:
> +    description: |
> +      ETSI 5.8 GHz SRD (Short Range Device) channel configuration.
> +      Controls how the driver handles the 5725-5875 MHz (5.8 GHz) SRD
> +      channels in ETSI regulatory domains.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00

What? If it is 0 then just drop it. Same comments everywhere else.

> +        [1] value    - channel configuration:
> +                       0 =3D active scan permitted (default behaviour)
> +                       1 =3D passive scan only; device may associate and
> +                           transfer data but must not transmit probe
> +                           requests on SRD channels
> +                       2 =3D SRD channels fully disabled; the device must
> +                           not scan, associate, or operate on any of the
> +                           5725-5875 MHz SRD channels

I have doubts this is regulatory/certification property.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0

Drop

> +          - enum: [0, 1, 2]

Use string

> +
> +  intel,6e-uhb:
> +    description: |
> +      6-7 GHz Ultra-High Band (UHB) per-country enable bitmask.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - UHB enablement control:
> +                       bit 0:     override control; 0 =3D use device def=
aults,
> +                                  1 =3D force-disable all countries not
> +                                  explicitly enabled in bits 1-25
> +                       bits 1-25: per-country/region enable flags:
> +                                  bit  1 =3D USA
> +                                  bit  2 =3D Rest of World (ROW)
> +                                  bit  3 =3D EU
> +                                  bit  4 =3D South Korea
> +                                  bit  5 =3D Brazil
> +                                  bit  6 =3D Chile
> +                                  bit  7 =3D Japan
> +                                  bit  8 =3D Canada
> +                                  bit  9 =3D Morocco
> +                                  bit 10 =3D Mongolia
> +                                  bit 11 =3D Malaysia
> +                                  bit 12 =3D Saudi Arabia
> +                                  bit 13 =3D Mexico
> +                                  bit 14 =3D Nigeria
> +                                  bit 15 =3D Thailand
> +                                  bit 16 =3D Singapore
> +                                  bit 17 =3D Taiwan
> +                                  bit 18 =3D South Africa
> +                                  bit 19 =3D Philippines
> +                                  bit 20 =3D Serbia
> +                                  bit 21 =3D Indonesia
> +                                  bit 22 =3D Azerbaijan
> +                                  bit 23 =3D Paraguay
> +                                  bit 24 =3D Vietnam
> +                                  bit 25 =3D India
> +                       bit 26:    reserved, must be 0

Bindings CANNOT be reserved.

> +                       bit 27:    enable VLP active scan, SoftAP, and
> +                                  P2P-GO operation in Japan
> +                       bit 28:    reserved, must be 0

NAK

> +                       bit 29:    enable VLP (Very Low Power) mode per
> +                                  country-by-country table
> +                       bit 30:    enable AFC (Standard Power) mode per
> +                                  country-by-country table
> +                       bit 31:    LPI override mode; 0 =3D use grouping
> +                                  mechanism, 1 =3D use country-by-countr=
y table
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0

No. If it is const, then it is implied by compatible.

> +          - {}
> +
> +  intel,regulatory-special:
> +    description: |
> +      Regulatory Special Configurations.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00

NAK

> +        [1] bitmap   - configuration flags:
> +                       bits 0-3: reserved, must be 0
> +                       bit 4 =3D Australia UHB extension
> +                       bits 5-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,activate-channel:
> +    description: |
> +      Indoor channel activation bitmask. Sets specific frequency bands to
> +      active (rather than passive or disabled) when the platform is
> +      confirmed to be operating indoors.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-region indoor activation flags:
> +                       bit 0 =3D enable EU U-NII-1 (5.2 GHz) for indoors=
 only
> +                       bit 1 =3D enable Japan U-NII-1 (5.2 GHz) for indo=
ors only
> +                       bit 2 =3D enable China Mainland U-NII-1 (5.2 GHz)
> +                               for indoors only
> +                       bit 3 =3D enable USA U-NII-4 (5.9 GHz) for indoor=
s only
> +                       bit 4 =3D enable WW U-NII-1 (5.2 GHz) for indoors=
 in any
> +                               country where the band is permitted
> +                       bit 5 =3D enable Canada U-NII-4 (5.9 GHz) for ind=
oors only
> +                       bit 6 =3D enable USA + Canada + WW U-NII-4 (5.9 G=
Hz) for
> +                               indoors only
> +                       bits 7-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,force-disable-channels:
> +    description: |
> +      Selective Wi-Fi band force-disable bitmask. Allows the platform to
> +      permanently disable specific frequency bands regardless of regulat=
ory
> +      domain.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-band force-disable flags:
> +                       bit 0  =3D force disable 2.4 GHz (channels 1-13)
> +                       bit 1  =3D force disable 5.2 GHz (channels 36-48)
> +                       bit 2  =3D force disable 5.3 GHz (channels 52-64)
> +                       bit 3  =3D force disable 5.5 GHz (channels 100-14=
4)
> +                       bit 4  =3D force disable 5.8 GHz (channels 149-16=
5)
> +                       bit 5  =3D force disable 5.9 GHz (channels 169-17=
7)
> +                       bit 6  =3D force disable 6.2 GHz (channels 1-93)
> +                       bit 7  =3D force disable 6.5 GHz (channels 97-113)
> +                       bit 8  =3D force disable 6.6 GHz (channels 117-15=
3)
> +                       bit 9  =3D force disable 6.8 GHz (channels 157-18=
5)
> +                       bit 10 =3D force disable 7.0 GHz (channels 185-23=
3)
> +                       bits 11-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,11be:
> +    description: |
> +      802.11be (Wi-Fi 7) per-country enable bitmask. Controls whether
> +      802.11be operation is permitted in specific countries.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-country enable flags:
> +                       bit 0 =3D enable 802.11be in China (CB/CN)
> +                       bit 1 =3D enable 802.11be in South Korea
> +                       bits 2-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,splc:
> +    description: |
> +      Wi-Fi Static Power Limit Capabilities (SPLC). Sets the platform th=
ermal
> +      power limit for the Wi-Fi core in mW. Omit this property entirely =
if
> +      no platform power limit applies; the device will use its certified
> +      maximum in that case.
> +
> +      Layout (2 cells):
> +        [0] revision    - structure revision, must be 0x00
> +        [1] power_limit - maximum platform power budget in mW, must be
> +                          non-zero (a zero value is equivalent to omitti=
ng
> +                          the property)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - minimum: 1
> +
> +  intel,wcpe:
> +    description: |
> +      Wi-Fi Channel Puncturing Enablement (WCPE). Enables 802.11be chann=
el
> +      puncturing for specific regulatory domains.
> +
> +      Layout (2 cells):
> +        [0] revision   - structure revision, must be 0x00
> +        [1] puncturing - per-country enable bitmask:
> +                         bit 0: 1 =3D channel puncturing enabled for USA
> +                         bit 1: 1 =3D channel puncturing enabled for Can=
ada
> +                         bits 2-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +  intel,wbem:
> +    description: |
> +      Wi-Fi 320 MHz Bandwidth Enablement per MCC (WBEM). Controls whether
> +      320 MHz operation is permitted in specific countries.
> +
> +      Layout (2 cells):
> +        [0] revision       - structure revision, must be 0x00
> +        [1] wifi320mhz_mcc - per-country enable bitmask:
> +                             bit 0: 1 =3D 320 MHz enabled for Japan
> +                             bit 1: 1 =3D 320 MHz enabled for South Korea
> +                             bits 2-31: reserved, must be 0
> +
> +                             Each bit takes effect only if the installed
> +                             module is certified for 320 MHz in that cou=
ntry.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          - const: 0
> +          - {}
> +
> +required:
> +  - compatible
> +  - reg
> +

Missing ref to ieee80211 schema.


> +additionalProperties: false

Best regards,
Krzysztof


