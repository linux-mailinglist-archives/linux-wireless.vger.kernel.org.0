Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8A2C628
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE1MIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:08:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:08:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 396BE6063A; Tue, 28 May 2019 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559045332;
        bh=RtXJvUfbgw1LtqQFqRyyk/z4x2/PjEJlT9VprU9ofVE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W96iT3+zpN/4O6QO0cF6AHOm+OI18Emf4AgIEryUfdH8YU7KXI3i6FQet6e2aVPVR
         B2oNTfbhh/WOmKIXSzzrHdCtdVBx4Y4MKBKn/dVkaN8Cm2JCf7whES1t6EfNRDYWLX
         JxYLNvfckaZCIQZAa1FY6f5ctyVXlcu7FsU0/O4A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1DFC60271;
        Tue, 28 May 2019 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559045331;
        bh=RtXJvUfbgw1LtqQFqRyyk/z4x2/PjEJlT9VprU9ofVE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=csNqf+XKKN2droBRW1OSVU7cAKPPGaGpEYn0RrkB1SKAatjMhtw5a/cWM2nYKaTTA
         bLIoFoy06GoGASMq5w+VHPtakWZKUAMk9Jp6AYfEqK4rBGrRZxZyNiif+xcLbT/CBE
         hLEmGkR3AOv8AUlP6Jy6NCuZingAV9hadXnz6NAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1DFC60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: Re: [RFC] rtlwifi: rtl8821ae: Use inline routines rather than macros for descriptor word 0
References: <20190506173916.16486-1-Larry.Finger@lwfinger.net>
Date:   Tue, 28 May 2019 15:08:48 +0300
In-Reply-To: <20190506173916.16486-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Mon, 6 May 2019 12:39:16 -0500")
Message-ID: <87y32q4w8f.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> The driver uses complicated macros to set parts of word 0 of the TX and RX
> descriptors. These are changed into inline routines.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>
> Kalle,
>
> Based on your comment on how much you dislike those "byte macros", I have
> converted a few of them from rtl8821ae into static inline functions.
>
> Is this what you had in mind, and do you consider these changes to
> improve the code?

[...]

> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
> @@ -14,25 +14,67 @@
>  #define USB_HWDESC_HEADER_LEN			40
>  #define CRCLENGTH						4
>  
> -#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 16, __val)
> -#define SET_TX_DESC_OFFSET(__pdesc, __val)			\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 16, 8, __val)
> -#define SET_TX_DESC_BMC(__pdesc, __val)				\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 24, 1, __val)
> -#define SET_TX_DESC_HTC(__pdesc, __val)				\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 25, 1, __val)
> -#define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 26, 1, __val)
> -#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
> -#define SET_TX_DESC_LINIP(__pdesc, __val)			\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
> -#define SET_TX_DESC_OWN(__pdesc, __val)				\
> -	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
> -
> -#define GET_TX_DESC_OWN(__pdesc)					\
> -	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
> +/* Set packet size (16 bits) in TX descriptor word 0 */
> +static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u16 __val)
> +{
> +	*__pdesc = cpu_to_le32((le32_to_cpu(*__pdesc) & ~GENMASK(0, 15)) |
> +			       __val);
> +}

This was not exactly what I had mind. My point was that the firmware
command or event should be handled as a complete structure, not parsed
one (or four) bytes at a time. To show what I mean here's a random
example from iwlwifi:

struct iwl_alive_resp {
	u8 ucode_minor;
	u8 ucode_major;
	__le16 reserved1;
	u8 sw_rev[8];
	u8 ver_type;
	u8 ver_subtype;			/* not "9" for runtime alive */
	__le16 reserved2;
	__le32 log_event_table_ptr;	/* SRAM address for event log */
	__le32 error_event_table_ptr;	/* SRAM address for error log */
	__le32 timestamp;
	__le32 is_valid;
} __packed;

This a nice, clean and robust way both use AND document an event coming
from the firmware. And the driver can pass around 'struct iwl_alive_res
*resp' pointer to other functions to make it easy to understand what
event the buffer contains. Compared to rtlwifi where there's just 'u8
buf[]' and nobody has any clue what it contains, and need to spend at
least five minutes figuring that out everytime they are looking at a
function.

But to be honest I'm not sure if it's worth trying to cleanup rtlwifi,
it really would need a full rewrite to become a clean driver. IMHO much
better to put more effort on rtl8xxxxu and rtw88, which both already are
clean drivers.

-- 
Kalle Valo
