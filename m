Return-Path: <linux-wireless+bounces-35587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBDYBcPR8Wm3kgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:39:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6BB4921E1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5853F3019520
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00994394470;
	Wed, 29 Apr 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC+fKy59"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129E3921C2;
	Wed, 29 Apr 2026 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455255; cv=none; b=hA5Wr4bYFyHKrA/zgxzeK4Fafk0FdgGCvyYx2OK85xB272uM24sPy7zkJU2kzeyxeZFF1c9q3ObdSZlR5CRMSOc+9t0j4T+RvRfnf61QsiOxgMlC2/38lknxG8//vsHZ23z+5ZnuXGKR4+0vTTxjKB9IbABU4MlSWWdNjDSM6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455255; c=relaxed/simple;
	bh=u3toxTEJgbhB59Lpk2WKlSojq3rFP8wovjYLrHyZBr0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=trEYg9D6q4kDLnOiTDeg7efVYB1lUq8tY8VfnJmEBRK4zGMJ0mFKGoS5kZZx0+edfvn43EhRoDVtYM6r1qBZOe5o9W2lVXCEtgg8NgA/A/er1nm79aulGY99AktBjoqC1gBrsoV/fre3ryDqTv2EuiXypvvdLFjZQ2nye4cezsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC+fKy59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E1C19425;
	Wed, 29 Apr 2026 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777455255;
	bh=u3toxTEJgbhB59Lpk2WKlSojq3rFP8wovjYLrHyZBr0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HC+fKy59/HbXZ7rjeOl9dT0/8d3nKoG6ZSS3YnrYLqeO856FxBlwEab4WR/Awgfyo
	 YjoXI+8tsWfaI9tit/NENzevtdMPRNIHk2iRH4qVjwmLWN0miwi7knMKY0cyGZL1bp
	 x1w3XmEO3BSlYWkZo6uQzmZCoa3mgZxRsl62ksD+YH/zYkXUoiWLvWSA9PS0Dfvjmc
	 GYI32VTH+1frLWIbZfhypeoxNwNmogHydx97Oipup2jvkCb12/eYUuTPbrxqvnz54m
	 01zrcBrjWSR11LZMdnr5yfov5nuG8vWs63d6dJDNgSpznUY6skAsTrv9tYHG5PbKxT
	 mgmOLrkUmL/vA==
Date: Wed, 29 Apr 2026 04:34:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: miriam.rachel.korenblit@intel.com, devicetree@vger.kernel.org, 
 krzk+dt@kernel.org, emmanuel.grumbach@intel.com, 
 linux-wireless@vger.kernel.org, conor+dt@kernel.org, 
 johannes@sipsolutions.net, kobi.guetta@intel.com, 
 linux-kernel@vger.kernel.org
To: Avinash Bhatt <avinash.bhatt@intel.com>
In-Reply-To: <20260429081403.46087-2-avinash.bhatt@intel.com>
References: <20260429081403.46087-1-avinash.bhatt@intel.com>
 <20260429081403.46087-2-avinash.bhatt@intel.com>
Message-Id: <177745525320.299703.826725062501048305.robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
X-Rspamd-Queue-Id: 6C6BB4921E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35587-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]


On Wed, 29 Apr 2026 11:14:03 +0300, Avinash Bhatt wrote:
> Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe
> adapters.
> 
> The binding documents OEM platform configuration properties for
> platforms that use Device Tree instead of platform firmware
> methods. All properties mirror the existing equivalents in
> structure and semantics, covering SAR power limits (intel,wrds),
> 6 GHz AP type support (intel,uats), static power limit
> (intel,splc), channel puncturing (intel,wcpe), 320 MHz per-MCC
> enablement (intel,wbem), ETSI SRD channel configuration
> (intel,srd), 6-7 GHz UHB country enable bitmask (intel,6e-uhb),
> and additional regulatory override properties.
> 
> Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
> ---
>  .../bindings/net/wireless/intel,iwlwifi.yaml  | 445 ++++++++++++++++++
>  1 file changed, 445 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,splc:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}, {'minimum': 1}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,splc:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}, {'minimum': 1}] is too long
	[{'const': 0}, {'minimum': 1}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,splc:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}, {'minimum': 1}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,splc:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}, {'minimum': 1}] is too long
	[{'const': 0}, {'minimum': 1}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wcpe:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wcpe:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wcpe:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wcpe:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,6e-uhb:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,6e-uhb:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,6e-uhb:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,6e-uhb:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,regulatory-special:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,regulatory-special:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,regulatory-special:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,regulatory-special:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,uats:allOf:1: {'minItems': 339, 'maxItems': 339, 'items': [{'const': 1}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,uats:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 339
	[{'const': 1}] is too short
	1 was expected
	339 is greater than the maximum of 2
	339 is greater than the maximum of 3
	339 is greater than the maximum of 4
	339 is greater than the maximum of 5
	339 is greater than the maximum of 6
	339 is greater than the maximum of 7
	339 is greater than the maximum of 8
	339 is greater than the maximum of 9
	339 is greater than the maximum of 10
	339 is greater than the maximum of 11
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,uats:allOf:1: {'minItems': 339, 'maxItems': 339, 'items': [{'const': 1}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,uats:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 339
	[{'const': 1}] is too short
	1 was expected
	339 is greater than the maximum of 2
	339 is greater than the maximum of 3
	339 is greater than the maximum of 4
	339 is greater than the maximum of 5
	339 is greater than the maximum of 6
	339 is greater than the maximum of 7
	339 is greater than the maximum of 8
	339 is greater than the maximum of 9
	339 is greater than the maximum of 10
	339 is greater than the maximum of 11
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,force-disable-channels:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,force-disable-channels:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,force-disable-channels:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,force-disable-channels:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wrds:allOf:1: {'minItems': 50, 'maxItems': 50, 'items': [{'const': 3}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wrds:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 50
	[{'const': 3}] is too short
	1 was expected
	50 is greater than the maximum of 2
	50 is greater than the maximum of 3
	50 is greater than the maximum of 4
	50 is greater than the maximum of 5
	50 is greater than the maximum of 6
	50 is greater than the maximum of 7
	50 is greater than the maximum of 8
	50 is greater than the maximum of 9
	50 is greater than the maximum of 10
	50 is greater than the maximum of 11
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wrds:allOf:1: {'minItems': 50, 'maxItems': 50, 'items': [{'const': 3}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wrds:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 50
	[{'const': 3}] is too short
	1 was expected
	50 is greater than the maximum of 2
	50 is greater than the maximum of 3
	50 is greater than the maximum of 4
	50 is greater than the maximum of 5
	50 is greater than the maximum of 6
	50 is greater than the maximum of 7
	50 is greater than the maximum of 8
	50 is greater than the maximum of 9
	50 is greater than the maximum of 10
	50 is greater than the maximum of 11
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,activate-channel:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,activate-channel:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,activate-channel:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,activate-channel:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wbem:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wbem:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wbem:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,wbem:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,srd:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}, {'enum': [0, 1, 2]}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,srd:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}, {'enum': [0, 1, 2]}] is too long
	[{'const': 0}, {'enum': [0, 1, 2]}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,srd:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}, {'enum': [0, 1, 2]}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,srd:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}, {'enum': [0, 1, 2]}] is too long
	[{'const': 0}, {'enum': [0, 1, 2]}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,11be:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,11be:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,11be:allOf:1: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 0}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml: properties:intel,11be:allOf:1: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 2
	[{'const': 0}] is too short
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260429081403.46087-2-avinash.bhatt@intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


