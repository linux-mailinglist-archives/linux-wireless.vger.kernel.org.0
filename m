Return-Path: <linux-wireless+bounces-27741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7CFBACC5A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 14:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF98188ECA8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51B2F83B8;
	Tue, 30 Sep 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pOJ5Bo76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fk36Da/C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DD23183F;
	Tue, 30 Sep 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233962; cv=none; b=rQdMl1KY/W661St3AU2vQXaKDTTpTlxja2HifJZGhX/fvBLkd4HNDSTQ58tEFADwo639rfQ1kcFX73WNtiuWJzyZUKOwaADJU404m+p9AnhNtrKvuCNVP8MXxQrYOEd7ebhDof6AgDYjaForb6BrAPTRpH3xpdFuLtvod2kAxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233962; c=relaxed/simple;
	bh=jFIkL4prmYeCbZOsejsqEGgN4EPfp/Rp74PA+aBVUBs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N6POSC2EO2Owpps/TdnmdhfDiSGsfTHE8oOaQbXg7JcaBhMjew3+VRYbbq0RwLNDU213igmsibrE5+g65cqKCiXqhvhOUshlK3qZv4zc9UYqJTAZXamzLATS6dSx6cc2ikj4dvvWpTYkM8BlTwrU0TFFIT1ClWvmI3eeVjF72Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pOJ5Bo76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fk36Da/C; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD9057A0015;
	Tue, 30 Sep 2025 08:05:58 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Tue, 30 Sep 2025 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759233958;
	 x=1759320358; bh=nq0GN9PRh99W21XkvPPazW0cqGY5esYpC6Jj9s3RJ20=; b=
	pOJ5Bo76T+av2xZyEAwC3FZk7seiRsa8LDd0UV3oOeXRsjo+SZHj3uCdtY/9Kbf+
	KDBaU8TKHD4o3UIqcoeAaEZ0FWqHJ3sJTtl4xo2sTA7Gp+TFr4Okz02nqbjxTbdl
	XSsZbtOS2kwtsiz2Ea5gMfgEiNU6rUFEuBpzqvlO07xQOAKkA2StIyFQDuQgf1Tc
	q6Dxi4F85IQFpEQFzXngYfW0OJouf55045Fe/+/FkzJuHlOw3uTnQDSXlHDKeIRf
	TiehZ24PMMr0bD/vFsG4+VcLCbz9kkO14/uYVGxVoJjsmyFw5EniBd0mkpixd7TJ
	g0OBHbUrw3aR4P2Glt6vBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759233958; x=
	1759320358; bh=nq0GN9PRh99W21XkvPPazW0cqGY5esYpC6Jj9s3RJ20=; b=F
	k36Da/C/YvazKd2lJ1mI7pj58jEQ3JoeORk9b7XpfRh8YV0yhWGpk1e0+lCDZ1/m
	aZIQMuv6XQRFl4UBIfqSavwCT3iKqxdxfbexKn+qkreKYMECW+jbPGnLVhwEw53G
	WsO/E9nXnpMFAH6JGvOgxkKAMqyFQC6MpoaqXnFBkt6T+ZsFh7MYcNplGdKN+nb3
	/WaddGlaESZneKm1xswGvupm4W5GvV+pwy4SQPL++s2yRyDEvDTIiQMAp8+avAOv
	T+6gYOrd/Zw/9VUdGaWIRKAVP+44eHlbNHr+8uFOo+rOgCG8XWUl5sVHaDyo8AV0
	r3WWzfu3hd8pTVUPdoYKQ==
X-ME-Sender: <xms:psfbaJTMG-CGPVP-5WIVXAnkVRgg8JgxWjshy1S-RA_zILzmfGxV2g>
    <xme:psfbaNnmoTHJPHZlOlQcvGdNbiX0YzrNBiqs7atdFZGiZgZfsP9U0Jg6J8QvO86Km
    AleS-MyuMWi3Kl6qy2CqKEp2Z6TFcjefJp6G91G0rFQYyHbkkoFDxvX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnheptdffvefgtefhveetuddvfeelveektdduvdelgfehgfei
    keffjeetjeevffektdfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdq
    lhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjjhhohhhnshhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghthhduudhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepsggrohgthhgvnhdrqhhirghnghesohhsshdrqhhurghltghomhhmrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:psfbaM8JLF3MitQNge6OY6_-uJSMQXuYM5warZs8ex3cGXRxhwffUQ>
    <xmx:psfbaOCWUa0ySZebsqxclpBj7gItye9tpD1CDqcfH75hyfKfBN1m0w>
    <xmx:psfbaJRMQNZ_ui8uAz1FpEvaO_a6MB4_Csfbgv2F7PpO8dCVQJ_Tlg>
    <xmx:psfbaNuxzX2EU8mtb6K3gCy3vDo-MaTBN1A1P-nOQjmdRIWtMpwzNQ>
    <xmx:psfbaNdEi148Dd4pCKaf-U7idj3vyfY9b0R3_G5mLXy6yd2Ku01Ak0W7>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4E3092CE0072; Tue, 30 Sep 2025 08:05:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVTq1tek_bVo
Date: Tue, 30 Sep 2025 08:05:38 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <eddb5c03-e919-485b-a6d4-06485cd87db9@app.fastmail.com>
In-Reply-To: <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
 <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 29, 2025, at 10:17 PM, Baochen Qiang wrote:
> On 9/30/2025 3:21 AM, Mark Pearson wrote:
>> Lenovo platforms can come with one of two different IDs.
>> The pm_quirk table was missing the second ID for each platform.
>> 
>> Add missing ID and some extra platform identification comments.
>> Reported on https://bugzilla.kernel.org/show_bug.cgi?id=219196
>> 
>> Tested-on: P14s G4 AMD.
>
> Leave a blank line as 'Tested-on:' is not an official tag
>
>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
>
> Better to move the bugzilla link here and reword as below?
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196
>
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2:
>>  - Correct typo for T14s G4 AMD to use correct ID. Sorry!
>>  - Added in Fixes and Tested-on tags correctly.
>> 
>>  drivers/net/wireless/ath/ath11k/core.c | 54 +++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index d49353b6b2e7..47522fa186a1 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -912,42 +912,84 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>  static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /* X13 G4 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J3"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /* X13 G4 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>>  		},
>>  	},
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /* T14 G4 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K3"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /* T14 G4 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
>>  		},
>>  	},
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /* P14s G4 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K5"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /* P14s G4 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
>>  		},
>>  	},
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /* T16 G2 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K7"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /* T16 G2 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
>>  		},
>>  	},
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /*P16s G2 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K9"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /*P16s G2 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
>>  		},
>>  	},
>>  	{
>>  		.driver_data = (void *)ATH11K_PM_WOW,
>> -		.matches = {
>> +		.matches = { /*T14s G4 AMD #1 */
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21F8"),
>> +		},
>> +	},
>> +	{
>> +		.driver_data = (void *)ATH11K_PM_WOW,
>> +		.matches = { /*T14s G4 AMD #2 */
>>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>>  		},
>
> assuming Jeff can resolve above nits ...
>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Thanks for the review.
Jeff, let me know if you need a v3 with the small changes.

Mark

