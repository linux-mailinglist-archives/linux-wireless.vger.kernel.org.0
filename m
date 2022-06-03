Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3253D3BB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jun 2022 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbiFCW6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 18:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiFCW6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 18:58:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43F326F8
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 15:58:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o6so2700627plg.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jun 2022 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=ZBPSTCKeQbCc/bN5E41ihH4roNGUrxfAOnmKm+s532w=;
        b=C9E6rEjoeUVYR6Y3cZWBg7WCHarZAYcatVuu1IJsC7HvQ8rb3P22QpIR2dt5+cGw8G
         +3EFFLSMDuAW+0WMyOr+K68dQ/nZ8jfsETulN6mxBsnT791INBUyEak8tbflJTxzhdzt
         kDxrY7uSHFreImTVITrXc0fjHpxXL4aI+lcXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=ZBPSTCKeQbCc/bN5E41ihH4roNGUrxfAOnmKm+s532w=;
        b=EGbyhVlDruNC5HdpJPYXgzamdrtYeETq7I4FeGQ7GjeGPl8Hk9k1DsbT//R7Jp3Q1+
         hihwBx69jOoWgVxKC5tn/gQqzqDiHfodeAKDbESUvAGL9PAVmcgq1dowVA1FUE3IWmtj
         zQPbh3DPmREOMcR0U/Qi4OFQX1EPqrID/7WNb8Mc+CJbYKHkAhNlA7iD9MttYwV7qjcm
         9ZpdSt45y+fcbjER9OMfm2SSFuRdcsv+tTzutiybZauCdhzrPEDiAVC3zsvQb6vq5Aec
         pckTsGbOEn/QPNfhBSl7oQqxc98F+nob9ZsraOtTaPe+dXYGdx2EK+XOFqnx8p06uD5Q
         0w3Q==
X-Gm-Message-State: AOAM532596UDUbJnrtnb9Q91qi48G5n51o8wn4S6W+QLD4lC5hjLWLq5
        kpNgSvqhjNKXM66MlBXXDdyNMudZFFkWzGXYZ4P26BK0eUDW2KpBEoUj5ERz96CHxLGzsLv6e8s
        EI0iL73+ZeVNa7lUgEw==
X-Google-Smtp-Source: ABdhPJwvXyX5ry3uqFlWDc4DPTarlM+PzFQu2xDDtGdcavf0VOH9l/yjdTPLARNrk1jpo0OWBAajFA==
X-Received: by 2002:a17:902:e0c2:b0:167:6128:e63d with SMTP id e2-20020a170902e0c200b001676128e63dmr265274pla.16.1654297102199;
        Fri, 03 Jun 2022 15:58:22 -0700 (PDT)
Received: from smtpclient.apple ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b001621cd83e49sm5938277plm.92.2022.06.03.15.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2022 15:58:20 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to
 firmware-crash
From:   Franky Lin <franky.lin@broadcom.com>
In-Reply-To: <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
Date:   Fri, 3 Jun 2022 15:58:19 -0700
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Message-Id: <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
 <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
 <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000026e63d05e0930ff0"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000026e63d05e0930ff0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Danny,

>>=20
>> ------- Original Message -------
>> On Tuesday, May 24th, 2022 at 18:51, Danny van Heumen danny@dannyvanheum=
en.nl wrote:
>>>=20
>>> I investigated a crash that IIUC occurs with hardened memory allocation=
 enabled and a firmware-crash followed by an early failure during hardware =
reinitialization/probing. The hardened allocator detects double-free issue.
>>>=20
>>> I have created the patch (see attachment) against linux-5.18. Though, p=
lease check carefully, because I have not been able to confirm that it actu=
ally works. I am hoping someone familiar with the code-base can either test=
 this easily, or confirm from review/analysis.
>>>=20
>>> The commit message describes it in more detail. In summary:
>>> 'brcmf_sdio_bus_reset' cleans up and reinitializes the hardware. It fre=
es memory used by (struct brcmf_sdio_dev)->freezer (struct brcmf_sdiod_free=
zer). However, it then goes to probe the hardware, and an early failure to =
probe results in the same freeing, both called through function 'brcmf_sdio=
d_freezer_detach' called inside 'brcmf_sdiod_remove'. Which results in doub=
le freeing.
>>>=20

Thanks for reporting and sending out a patch to fix this.

If the problem is double freeing the freezer buffer, it should be addressed=
 from the root by setting pointer to NULL. Same thing might need to be done=
 for sg table as well. Sorry I don=E2=80=99t have any sdio module to reprod=
uce and test. Please see if the below change fixes the problem.

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index ac02244a6fdf..e9bad7197ba9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_sdi=
o_dev *sdiodev)
 	if (sdiodev->freezer) {
 		WARN_ON(atomic_read(&sdiodev->freezer->freezing));
 		kfree(sdiodev->freezer);
+		sdiodev->freezer =3D NULL;
 	}
 }
=20
@@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev)
 	sdio_disable_func(sdiodev->func1);
 	sdio_release_host(sdiodev->func1);
=20
-	sg_free_table(&sdiodev->sgtable);
+	if (sdiodev->sgtable) {
+		sg_free_table(&sdiodev->sgtable);
+		sdiodev->sgtable =3D NULL;
+	}
+
 	sdiodev->sbwad =3D 0;
=20
 	pm_runtime_allow(sdiodev->func1->card->host->parent);

As for submitting patch to linux-wireless, please follow the guideline. [1]

Thanks,
- Franky

[1] https://wireless.wiki.kernel.org/en/developers/documentation/submitting=
patches



--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--00000000000026e63d05e0930ff0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQZwYJKoZIhvcNAQcCoIIQWDCCEFQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2+MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUYwggQuoAMCAQICDD+oOemy/B2WnF/vHTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNDM2NDdaFw0yMjA5MDEwODAzMTBaMIGK
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xEzARBgNVBAMTCkZyYW5reSBMaW4xJjAkBgkqhkiG9w0BCQEW
F2ZyYW5reS5saW5AYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
wQl9LnrpCI0LsPyQgaFENSGK3TXA2Him11nmCkxOvfXQGEp06qSWVGhJJ4uh74eqapwDI/hBlRub
+Y9V5uX9n4UN8diL0WxhYqluRaCYBwsUdEmuGwoWN/M+3ZPVV7Zch1euKcQTB/cYWeig1oPnftVL
wMJUaEX5tSrUJh1y0INMVPIB/spvvKR4Hzlf+k29wI2TOFzPoIZRPQtWnx4OKqEx8unyGPozc9GI
kjY1BnpEEF8LCZw5w2Xi0x6RQM2QSte4iTxLzeLvVFJLJj1KtNi1VWvXYCzMuTbhLMikZHLqMxkf
4oNJJGHKt8xzvUC1Tu5vjMbOCEgQD5Ikz2gOLwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEKPgvCN0J2rCGluIqTKO+62QXKgwDQYJ
KoZIhvcNAQELBQADggEBAIlQsf/NPacuX/yG96v+J49ix14aQ6BYdmSvmuabgx/vWk/pjLsQkPBD
lW4mwEblmXeGUDOZBE494ybTSYo7XWTuFdWd1FuCipxnzMJ+WAtf7NiXW8Ayrfttq6i+4+AAjwHu
gs5HcDKeBuQEC3XVssC/06M32EuxlkCxKrQXNqYzkMJ5fdLLVPpFjjsK2fH/X2X8muS8KT4GXbUs
HGETPmDhjFb5DzuWn33x2GmWziWNQExeyehcQPFhE0rJMX6lLa2IOMLRi8FNPyb3Fa28AOyh4XOh
sQ+3AGeTN+7hJgf8DM9I47l561iQfieaicKnM/WPpmbIMuqLHbCOvgK2PFExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw/qDnpsvwdlpxf7x0wDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMkPC0VyAjS0CjTFBoT9YiuYOYp7okP6hzDrp/zT
+LtFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYwMzIyNTgy
MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAuD4t38BFHDQ9ZG4C8aYmdR6FQfMYJ72n1/91kQt/HYpxLG6EmtoIG+Zpd
mm6b2WO5q7+y+B8AsfhmD50q7JdCkRyCtqTMPEjQSTpoY4G5NiQfgX/RopHgBq48bWYSeclpo/fV
BzLaYSLv9CQkDjzRmvVMV/To1EKZce/mdAXFoCgGMeIB1qtrfcCXTkLFwKSMMRqgmVmfkLWjmhS+
p/tozz3nDVq5dFF2vEcpvIxk0eU8J2TKBt7/AVZ2+w14sGOrrDGb7EmG3FypyyzkRpez+g8VnNHE
RxeLQVOkAcEJuqwDGb+sgPaVl80EWMtqYcRJMS0tDcolw5BKpQZcChHV
--00000000000026e63d05e0930ff0--
